# KNN---Hardware-Classifier
KNN  classifier on Iris dataset implemented in verilog and python both.

## File Structure
├── input_register.v   # Feature buffer (clocked register)
├── dist_calc.v        # Manhattan distance calculator
├── knn_top.v          # Top module — KNN logic + training data
├── knn_top_tb.v       # Testbench (simulation & verification)
└── IRIS_data.ipynb    # Python preprocessing notebook
