module knn_tb;

    // inputs to DUT
    reg [7:0] test0, test1, test2, test3;

    // output from DUT
    wire [1:0] predicted_class;

    // expected label for checking
    reg [1:0] expected;

    // pass counter
    integer pass_count;

    // instantiate knn_top
    knn_top uut (
        .test0(test0),
        .test1(test1),
        .test2(test2),
        .test3(test3),
        .predicted_class(predicted_class)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, knn_tb);

        pass_count = 0;

        // ── Test sample 0 ──────────────────────────────────────
        test0=8'd135; test1=8'd85; test2=8'd166; test3=8'd117; expected=2'd1; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 0  | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 0  | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 1 ──────────────────────────────────────
        test0=8'd105; test1=8'd191; test2=8'd31; test3=8'd21; expected=2'd0; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 1  | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 1  | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 2 (clamped 264→255) ────────────────────
        test0=8'd255; test1=8'd64; test2=8'd255; test3=8'd234; expected=2'd2; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 2  | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 2  | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 3 ──────────────────────────────────────
        test0=8'd128; test1=8'd96; test2=8'd157; test3=8'd149; expected=2'd1; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 3  | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 3  | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 4 ──────────────────────────────────────
        test0=8'd187; test1=8'd85; test2=8'd170; test3=8'd138; expected=2'd1; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 4  | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 4  | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 5 ──────────────────────────────────────
        test0=8'd83; test1=8'd149; test2=8'd22; test3=8'd32; expected=2'd0; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 5  | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 5  | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 6 ──────────────────────────────────────
        test0=8'd98; test1=8'd96; test2=8'd116; test3=8'd128; expected=2'd1; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 6  | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 6  | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 7 ──────────────────────────────────────
        test0=8'd195; test1=8'd117; test2=8'd183; test3=8'd234; expected=2'd2; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 7  | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 7  | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 8 ──────────────────────────────────────
        test0=8'd142; test1=8'd21; test2=8'd157; test3=8'd149; expected=2'd1; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 8  | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 8  | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 9 ──────────────────────────────────────
        test0=8'd112; test1=8'd74; test2=8'd130; test3=8'd117; expected=2'd1; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 9  | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 9  | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 10 ─────────────────────────────────────
        test0=8'd165; test1=8'd128; test2=8'd183; test3=8'd202; expected=2'd2; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 10 | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 10 | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 11 ─────────────────────────────────────
        test0=8'd37; test1=8'd106; test2=8'd18; test3=8'd0; expected=2'd0; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 11 | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 11 | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 12 ─────────────────────────────────────
        test0=8'd90; test1=8'd159; test2=8'd13; test3=8'd11; expected=2'd0; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 12 | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 12 | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 13 ─────────────────────────────────────
        test0=8'd45; test1=8'd117; test2=8'd22; test3=8'd0; expected=2'd0; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 13 | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 13 | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 14 ─────────────────────────────────────
        test0=8'd60; test1=8'd191; test2=8'd22; test3=8'd21; expected=2'd0; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 14 | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 14 | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 15 ─────────────────────────────────────
        test0=8'd150; test1=8'd138; test2=8'd166; test3=8'd159; expected=2'd1; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 15 | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 15 | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 16 ─────────────────────────────────────
        test0=8'd165; test1=8'd106; test2=8'd215; test3=8'd223; expected=2'd2; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 16 | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 16 | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 17 ─────────────────────────────────────
        test0=8'd98; test1=8'd53; test2=8'd130; test3=8'd106; expected=2'd1; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 17 | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 17 | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 18 ─────────────────────────────────────
        test0=8'd105; test1=8'd85; test2=8'd157; test3=8'd128; expected=2'd1; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 18 | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 18 | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 19 ─────────────────────────────────────
        test0=8'd158; test1=8'd85; test2=8'd206; test3=8'd223; expected=2'd2; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 19 | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 19 | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 20 ─────────────────────────────────────
        test0=8'd30; test1=8'd128; test2=8'd27; test3=8'd11; expected=2'd0; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 20 | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 20 | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 21 ─────────────────────────────────────
        test0=8'd135; test1=8'd106; test2=8'd174; test3=8'd181; expected=2'd2; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 21 | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 21 | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 22 ─────────────────────────────────────
        test0=8'd52; test1=8'd149; test2=8'd27; test3=8'd32; expected=2'd0; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 22 | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 22 | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 23 ─────────────────────────────────────
        test0=8'd158; test1=8'd85; test2=8'd206; test3=8'd213; expected=2'd2; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 23 | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 23 | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 24 (clamped 270→255) ───────────────────
        test0=8'd255; test1=8'd191; test2=8'd242; test3=8'd202; expected=2'd2; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 24 | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 24 | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 25 ─────────────────────────────────────
        test0=8'd180; test1=8'd106; test2=8'd188; test3=8'd234; expected=2'd2; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 25 | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 25 | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 26 ─────────────────────────────────────
        test0=8'd180; test1=8'd53; test2=8'd215; test3=8'd181; expected=2'd2; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 26 | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 26 | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 27 ─────────────────────────────────────
        test0=8'd187; test1=8'd128; test2=8'd219; test3=8'd234; expected=2'd2; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 27 | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 27 | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 28 ─────────────────────────────────────
        test0=8'd37; test1=8'd106; test2=8'd18; test3=8'd21; expected=2'd0; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 28 | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 28 | got=%0d | exp=%0d", predicted_class, expected);

        // ── Test sample 29 ─────────────────────────────────────
        test0=8'd37; test1=8'd117; test2=8'd27; test3=8'd11; expected=2'd0; #20;
        if(predicted_class==expected) begin pass_count=pass_count+1; $display("PASS 29 | got=%0d | exp=%0d", predicted_class, expected); end
        else $display("FAIL 29 | got=%0d | exp=%0d", predicted_class, expected);

        // ── Final accuracy ──────────────────────────────────────
        $display("─────────────────────────────────────");
        $display("Hardware Accuracy: %0d / 30", pass_count);
        $display("─────────────────────────────────────");

        $finish;
    end

endmodule
