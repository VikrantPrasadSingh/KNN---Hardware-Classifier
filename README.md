# KNN Hardware Classifier — Iris Dataset

> A K-Nearest Neighbour (KNN) classifier for the Iris flower dataset, implemented in **both Verilog (RTL hardware)** and **Python**, demonstrating how a classical ML algorithm can be translated into synthesisable digital hardware.

---

## Table of Contents

- [Overview](#overview)
- [How KNN Works](#how-knn-works)
- [Project Architecture](#project-architecture)
- [File Structure](#file-structure)
- [Module Details](#module-details)
  - [dist_calc.v — Manhattan Distance Calculator](#dist_calcv--manhattan-distance-calculator)
  - [input_register.v — Feature Input Buffer](#input_registerv--feature-input-buffer)
  - [knn_top.v — Top-Level KNN Module](#knn_topv--top-level-knn-module)
  - [knn_tb.v — Testbench](#knn_tbv--testbench)
  - [IRIS_data.ipynb — Python Preprocessing Notebook](#iris_dataipynb--python-preprocessing-notebook)
- [Dataset](#dataset)
- [Hardware Design Decisions](#hardware-design-decisions)
- [Getting Started](#getting-started)
  - [Running the Verilog Simulation](#running-the-verilog-simulation)
  - [Running the Python Notebook](#running-the-python-notebook)
- [Prerequisites](#prerequisites)
- [Results](#results)

---

## Overview

This project implements a **k=3 KNN classifier** that classifies Iris flowers into one of three species:

| Label | Species |
|-------|----------------|
| `2'b00` | *Iris setosa* |
| `2'b01` | *Iris versicolor* |
| `2'b10` | *Iris virginica* |

The hardware implementation is written in **Verilog** and is designed to be fully synthesisable. It takes a 4-feature test point as input and outputs the predicted class label using majority voting among the 3 nearest training samples. The Python notebook serves as a reference implementation and data preprocessing tool.

---

## How KNN Works

KNN is a non-parametric, instance-based classification algorithm:

1. **Store** all training data points with their known labels.
2. **Compute** the distance between the test point and every training point.
3. **Select** the k smallest distances (the k nearest neighbours).
4. **Vote** — assign the class that appears most frequently among the k neighbours.

In this project, **k = 3** and distance is measured using the **Manhattan (L1) metric**, which is hardware-friendly since it requires only subtraction and addition (no multiplication or square roots).

---

## Project Architecture

```
Test Input (4 × 8-bit features)
         │
         ▼
  ┌──────────────┐
  │input_register│  ← Clocked feature buffer
  └──────┬───────┘
         │
         ▼
  ┌──────────────────────────────────────┐
  │  120 × dist_calc instances           │  ← Fully parallel distance computation
  │  (Manhattan distance, combinational) │
  └──────────────┬───────────────────────┘
                 │ 120 × 10-bit distances
                 ▼
  ┌──────────────────────────────────────┐
  │          knn_top                     │
  │  ┌────────────────────────────────┐  │
  │  │  Sequential minimum-find loop  │  │  ← Finds 3 nearest neighbours
  │  │  (1st → 2nd → 3rd nearest)     │  │
  │  └──────────────┬─────────────────┘  │
  │                 │                    │
  │  ┌──────────────▼─────────────────┐  │
  │  │     Majority Vote (k=3)        │  │  ← Class 0 → 1 → 2 priority
  │  └──────────────┬─────────────────┘  │
  └─────────────────┼────────────────────┘
                    ▼
         predicted_class [1:0]
```

---

## File Structure

```
KNN---Hardware-Classifier/
├── dist_calc.v        # Manhattan distance calculator (combinational)
├── input_register.v   # Clocked 4-feature input register
├── knn_top.v          # Top-level KNN module with training data + voting logic
├── knn_tb.v           # Verilog testbench for simulation & verification
└── IRIS_data.ipynb    # Python notebook: data exploration & preprocessing
```

---

## Module Details

### `dist_calc.v` — Manhattan Distance Calculator

A compact, **purely combinational** module that computes the Manhattan distance between two 4-dimensional points.

**Ports:**

| Port | Width | Direction | Description |
|------|-------|-----------|-------------|
| `A1–A4` | 8-bit | Input | Test point features |
| `B1–B4` | 8-bit | Input | Training point features |
| `D` | 10-bit | Output | Manhattan distance sum |

**How it works:**

Each feature pair is subtracted using absolute-value logic (ternary conditional), then all four differences are summed:

```verilog
wire [7:0] d1 = (A1 >= B1) ? (A1 - B1) : (B1 - A1);
assign D = d1 + d2 + d3 + d4;
```

The output is 10 bits wide to safely hold the maximum possible Manhattan distance (4 × 255 = 1020).

---

### `input_register.v` — Feature Input Buffer

A **clocked register** that latches the 4 input features on the rising clock edge. This is the synchronous entry point into the design, isolating combinational distance logic from any upstream timing noise.

---

### `knn_top.v` — Top-Level KNN Module

The heart of the design. It contains:

**Training Data (ROM-style `initial` block)**

120 training samples with 4 features each (8-bit, pre-scaled from original Iris float values) and 2-bit class labels, stored in `reg` arrays and synthesised into hardware ROM.

**Parallel Distance Computation**

Uses a `generate` loop to instantiate **120 independent `dist_calc` modules**, computing all distances simultaneously in a single combinational pass — a key advantage of hardware over software:

```verilog
genvar gi;
generate
  for (gi = 0; gi < 120; gi = gi + 1) begin : dist_units
    dist_calc u (
      .A1(test0), .A2(test1), .A3(test2), .A4(test3),
      .B1(train_data[gi][0]), ...
      .D(dist_out[gi])
    );
  end
endgenerate
```

**K-Nearest Neighbour Selection**

An `always @(*)` combinational block iterates through the 120 distance outputs to find the 3 nearest neighbours using a sequential minimum-find approach (first minimum, mark it out, repeat):

- Finds the 1st nearest, marks its distance as `10'h3FF` (infinity)
- Finds the 2nd nearest, marks it out
- Finds the 3rd nearest

**Majority Voting**

Counts how many of the 3 nearest neighbours belong to each class. The class with ≥ 2 votes wins. Tie-breaking priority: class 0 > class 1 > class 2.

**Top-level Ports:**

| Port | Width | Direction | Description |
|------|-------|-----------|-------------|
| `test0–test3` | 8-bit | Input | 4 features of the test point |
| `dist_out` | 10-bit × 120 | Output | All computed distances (for debug) |
| `predicted_class` | 2-bit | Output | Final predicted Iris class |

---

### `knn_tb.v` — Testbench

A simulation testbench that drives test vectors into `knn_top`, observes the `predicted_class` output, and can be used to verify correctness against expected labels from the Python notebook.

---

### `IRIS_data.ipynb` — Python Preprocessing Notebook

A Jupyter Notebook that handles:

- **Loading** the Iris dataset (via `sklearn.datasets` or CSV)
- **Exploring** the data: feature distributions, class balance, pairwise scatter plots
- **Scaling** float features to 8-bit unsigned integers (0–255) to match the hardware's fixed-point representation
- **Splitting** into training (120 samples) and test (30 samples) sets
- **Reference KNN** implementation in Python to validate the hardware design's expected accuracy
- **Exporting** scaled training data for embedding into Verilog

---

## Dataset

The [Iris dataset](https://archive.ics.uci.edu/ml/datasets/iris) is a classic ML benchmark with:

- **150 samples** total, 50 per class
- **4 features**: sepal length, sepal width, petal length, petal width (all in cm)
- **3 classes**: *Iris setosa*, *Iris versicolor*, *Iris virginica*

For hardware, the float feature values are **linearly scaled to 8-bit integers** (range 0–255), preserving relative distances while enabling fixed-width arithmetic in silicon.

The project uses **120 samples for training** and reserves 30 for testing.

---

## Hardware Design Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Distance metric | Manhattan (L1) | No multipliers or square roots; pure add/subtract |
| Feature width | 8-bit | Balances precision with resource use |
| Distance width | 10-bit | Fits max value of 4 × 255 = 1020 without overflow |
| Parallelism | 120 dist_calc instances | All distances computed in one clock cycle |
| k value | 3 | Odd number avoids ties; good accuracy on Iris |
| Training storage | `initial` block registers | Synthesises to ROM; no external memory needed |
| Voting | Combinational majority logic | Zero-latency classification after distances are ready |

---

## Getting Started

### Running the Verilog Simulation

Any standard Verilog simulator works. Example using **Icarus Verilog** (free & open-source):

```bash
# Install Icarus Verilog (if not already installed)
sudo apt install iverilog   # Ubuntu/Debian
brew install icarus-verilog # macOS

# Compile
iverilog -o knn_sim knn_tb.v knn_top.v dist_calc.v input_register.v

# Run simulation
vvp knn_sim
```

To view waveforms, dump a VCD in the testbench and open with GTKWave:

```bash
gtkwave dump.vcd
```

You can also synthesise the design using **Xilinx Vivado**, **Intel Quartus**, or **Yosys** for FPGA deployment.

---

### Running the Python Notebook

```bash
# Install dependencies
pip install numpy pandas matplotlib scikit-learn jupyter

# Launch Jupyter
jupyter notebook IRIS_data.ipynb
```

---

## Prerequisites

**For Verilog:**
- Icarus Verilog (`iverilog`) — or any Verilog-2001 compatible simulator
- GTKWave (optional, for waveform viewing)

**For Python:**
- Python 3.7+
- `numpy`, `pandas`, `matplotlib`, `scikit-learn`, `jupyter`

---

## Results

The KNN classifier (k=3, Manhattan distance) achieves high accuracy on the Iris dataset. The Python notebook demonstrates the expected classification performance, and the Verilog testbench confirms matching behaviour in hardware.

Typical KNN accuracy on Iris with an 80/20 train-test split: **~96–98%**.

---

## Author

**Vikrant Prasad Singh**
[GitHub Profile](https://github.com/VikrantPrasadSingh)
