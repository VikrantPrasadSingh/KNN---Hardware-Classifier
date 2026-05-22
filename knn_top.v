// KNN TOP  —  k=3, 120 training points, 4 features, 3 classes

module knn_top (
    input  [7:0] test0, test1, test2, test3,  // test-point features
    output [9:0] dist_out [0:119],           
    output reg [1:0] predicted_class          
);

    // ── training data 
    reg [7:0] train_data   [0:119][0:3];
    reg [1:0] train_labels [0:119];

 

    initial begin
        train_data[0][0]=8'd22; train_data[0][1]=8'd170; train_data[0][2]=8'd0; train_data[0][3]=8'd11; train_labels[0]=2'd0;
        train_data[1][0]=8'd105; train_data[1][1]=8'd255; train_data[1][2]=8'd22; train_data[1][3]=8'd32; train_labels[1]=2'd0;
        train_data[2][0]=8'd180; train_data[2][1]=8'd117; train_data[2][2]=8'd152; train_data[2][3]=8'd138; train_labels[2]=2'd1;
        train_data[3][0]=8'd37; train_data[3][1]=8'd149; train_data[3][2]=8'd27; train_data[3][3]=8'd11; train_labels[3]=2'd0;
        train_data[4][0]=8'd8; train_data[4][1]=8'd128; train_data[4][2]=8'd13; train_data[4][3]=8'd11; train_labels[4]=2'd0;
        train_data[5][0]=8'd150; train_data[5][1]=8'd53; train_data[5][2]=8'd179; train_data[5][3]=8'd191; train_labels[5]=2'd2;
        train_data[6][0]=8'd158; train_data[6][1]=8'd128; train_data[6][2]=8'd157; train_data[6][3]=8'd149; train_labels[6]=2'd1;
        train_data[7][0]=8'd68; train_data[7][1]=8'd159; train_data[7][2]=8'd22; train_data[7][3]=8'd11; train_labels[7]=2'd0;
        train_data[8][0]=8'd52; train_data[8][1]=8'd170; train_data[8][2]=8'd18; train_data[8][3]=8'd11; train_labels[8]=2'd0;
        train_data[9][0]=8'd68; train_data[9][1]=8'd223; train_data[9][2]=8'd22; train_data[9][3]=8'd0; train_labels[9]=2'd0;
        train_data[10][0]=8'd112; train_data[10][1]=8'd74; train_data[10][2]=8'd183; train_data[10][3]=8'd191; train_labels[10]=2'd2;
        train_data[11][0]=8'd128; train_data[11][1]=8'd149; train_data[11][2]=8'd157; train_data[11][3]=8'd159; train_labels[11]=2'd1;
        train_data[12][0]=8'd180; train_data[12][1]=8'd117; train_data[12][2]=8'd166; train_data[12][3]=8'd149; train_labels[12]=2'd1;
        train_data[13][0]=8'd83; train_data[13][1]=8'd202; train_data[13][2]=8'd13; train_data[13][3]=8'd32; train_labels[13]=2'd0;
        train_data[14][0]=8'd83; train_data[14][1]=8'd181; train_data[14][2]=8'd22; train_data[14][3]=8'd11; train_labels[14]=2'd0;
        train_data[15][0]=8'd90; train_data[15][1]=8'd42; train_data[15][2]=8'd121; train_data[15][3]=8'd96; train_labels[15]=2'd1;
        train_data[16][0]=8'd150; train_data[16][1]=8'd85; train_data[16][2]=8'd183; train_data[16][3]=8'd149; train_labels[16]=2'd2;
        train_data[17][0]=8'd158; train_data[17][1]=8'd117; train_data[17][2]=8'd201; train_data[17][3]=8'd181; train_labels[17]=2'd2;
        train_data[18][0]=8'd172; train_data[18][1]=8'd106; train_data[18][2]=8'd152; train_data[18][3]=8'd138; train_labels[18]=2'd1;
        train_data[19][0]=8'd217; train_data[19][1]=8'd170; train_data[19][2]=8'd228; train_data[19][3]=8'd255; train_labels[19]=2'd2;
        train_data[20][0]=8'd105; train_data[20][1]=8'd96; train_data[20][2]=8'd143; train_data[20][3]=8'd128; train_labels[20]=2'd1;
        train_data[21][0]=8'd247; train_data[21][1]=8'd106; train_data[21][2]=8'd251; train_data[21][3]=8'd213; train_labels[21]=2'd2;
        train_data[22][0]=8'd98; train_data[22][1]=8'd106; train_data[22][2]=8'd157; train_data[22][3]=8'd149; train_labels[22]=2'd1;
        train_data[23][0]=8'd60; train_data[23][1]=8'd159; train_data[23][2]=8'd18; train_data[23][3]=8'd11; train_labels[23]=2'd0;
        train_data[24][0]=8'd255; train_data[24][1]=8'd85; train_data[24][2]=8'd255; train_data[24][3]=8'd202; train_labels[24]=2'd2;
        train_data[25][0]=8'd112; train_data[25][1]=8'd74; train_data[25][2]=8'd139; train_data[25][3]=8'd96; train_labels[25]=2'd1;
        train_data[26][0]=8'd68; train_data[26][1]=8'd149; train_data[26][2]=8'd18; train_data[26][3]=8'd11; train_labels[26]=2'd0;
        train_data[27][0]=8'd52; train_data[27][1]=8'd159; train_data[27][2]=8'd13; train_data[27][3]=8'd21; train_labels[27]=2'd0;
        train_data[28][0]=8'd60; train_data[28][1]=8'd191; train_data[28][2]=8'd40; train_data[28][3]=8'd32; train_labels[28]=2'd0;
        train_data[29][0]=8'd52; train_data[29][1]=8'd0; train_data[29][2]=8'd112; train_data[29][3]=8'd96; train_labels[29]=2'd1;
        train_data[30][0]=8'd150; train_data[30][1]=8'd74; train_data[30][2]=8'd174; train_data[30][3]=8'd181; train_labels[30]=2'd2;
        train_data[31][0]=8'd37; train_data[31][1]=8'd149; train_data[31][2]=8'd40; train_data[31][3]=8'd11; train_labels[31]=2'd0;
        train_data[32][0]=8'd52; train_data[32][1]=8'd106; train_data[32][2]=8'd27; train_data[32][3]=8'd11; train_labels[32]=2'd0;
        train_data[33][0]=8'd60; train_data[33][1]=8'd138; train_data[33][2]=8'd31; train_data[33][3]=8'd43; train_labels[33]=2'd0;
        train_data[34][0]=8'd98; train_data[34][1]=8'd74; train_data[34][2]=8'd143; train_data[34][3]=8'd128; train_labels[34]=2'd1;
        train_data[35][0]=8'd60; train_data[35][1]=8'd149; train_data[35][2]=8'd22; train_data[35][3]=8'd11; train_labels[35]=2'd0;
        train_data[36][0]=8'd105; train_data[36][1]=8'd106; train_data[36][2]=8'd143; train_data[36][3]=8'd117; train_labels[36]=2'd1;
        train_data[37][0]=8'd255; train_data[37][1]=8'd191; train_data[37][2]=8'd255; train_data[37][3]=8'd223; train_labels[37]=2'd2;
        train_data[38][0]=8'd22; train_data[38][1]=8'd128; train_data[38][2]=8'd18; train_data[38][3]=8'd11; train_labels[38]=2'd0;
        train_data[39][0]=8'd142; train_data[39][1]=8'd96; train_data[39][2]=8'd148; train_data[39][3]=8'd128; train_labels[39]=2'd1;
        train_data[40][0]=8'd105; train_data[40][1]=8'd53; train_data[40][2]=8'd179; train_data[40][3]=8'd202; train_labels[40]=2'd2;
        train_data[41][0]=8'd90; train_data[41][1]=8'd234; train_data[41][2]=8'd18; train_data[41][3]=8'd11; train_labels[41]=2'd0;
        train_data[42][0]=8'd128; train_data[42][1]=8'd106; train_data[42][2]=8'd170; train_data[42][3]=8'd181; train_labels[42]=2'd2;
        train_data[43][0]=8'd112; train_data[43][1]=8'd74; train_data[43][2]=8'd183; train_data[43][3]=8'd191; train_labels[43]=2'd2;
        train_data[44][0]=8'd128; train_data[44][1]=8'd21; train_data[44][2]=8'd134; train_data[44][3]=8'd96; train_labels[44]=2'd1;
        train_data[45][0]=8'd83; train_data[45][1]=8'd106; train_data[45][2]=8'd157; train_data[45][3]=8'd149; train_labels[45]=2'd1;
        train_data[46][0]=8'd142; train_data[46][1]=8'd149; train_data[46][2]=8'd197; train_data[46][3]=8'd234; train_labels[46]=2'd2;
        train_data[47][0]=8'd90; train_data[47][1]=8'd32; train_data[47][2]=8'd134; train_data[47][3]=8'd128; train_labels[47]=2'd1;
        train_data[48][0]=8'd83; train_data[48][1]=8'd202; train_data[48][2]=8'd31; train_data[48][3]=8'd32; train_labels[48]=2'd0;
        train_data[49][0]=8'd52; train_data[49][1]=8'd32; train_data[49][2]=8'd103; train_data[49][3]=8'd96; train_labels[49]=2'd1;
        train_data[50][0]=8'd158; train_data[50][1]=8'd74; train_data[50][2]=8'd192; train_data[50][3]=8'd191; train_labels[50]=2'd2;
        train_data[51][0]=8'd52; train_data[51][1]=8'd138; train_data[51][2]=8'd18; train_data[51][3]=8'd11; train_labels[51]=2'd0;
        train_data[52][0]=8'd52; train_data[52][1]=8'd128; train_data[52][2]=8'd9; train_data[52][3]=8'd11; train_labels[52]=2'd0;
        train_data[53][0]=8'd90; train_data[53][1]=8'd42; train_data[53][2]=8'd125; train_data[53][3]=8'd106; train_labels[53]=2'd1;
        train_data[54][0]=8'd180; train_data[54][1]=8'd106; train_data[54][2]=8'd179; train_data[54][3]=8'd170; train_labels[54]=2'd1;
        train_data[55][0]=8'd45; train_data[55][1]=8'd117; train_data[55][2]=8'd22; train_data[55][3]=8'd11; train_labels[55]=2'd0;
        train_data[56][0]=8'd112; train_data[56][1]=8'd85; train_data[56][2]=8'd183; train_data[56][3]=8'd244; train_labels[56]=2'd2;
        train_data[57][0]=8'd52; train_data[57][1]=8'd149; train_data[57][2]=8'd22; train_data[57][3]=8'd11; train_labels[57]=2'd0;
        train_data[58][0]=8'd52; train_data[58][1]=8'd159; train_data[58][2]=8'd27; train_data[58][3]=8'd53; train_labels[58]=2'd0;
        train_data[59][0]=8'd120; train_data[59][1]=8'd128; train_data[59][2]=8'd170; train_data[59][3]=8'd181; train_labels[59]=2'd1;
        train_data[60][0]=8'd60; train_data[60][1]=8'd53; train_data[60][2]=8'd89; train_data[60][3]=8'd106; train_labels[60]=2'd1;
        train_data[61][0]=8'd195; train_data[61][1]=8'd128; train_data[61][2]=8'd210; train_data[61][3]=8'd234; train_labels[61]=2'd2;
        train_data[62][0]=8'd128; train_data[62][1]=8'd74; train_data[62][2]=8'd183; train_data[62][3]=8'd159; train_labels[62]=2'd1;
        train_data[63][0]=8'd135; train_data[63][1]=8'd64; train_data[63][2]=8'd206; train_data[63][3]=8'd138; train_labels[63]=2'd2;
        train_data[64][0]=8'd255; train_data[64][1]=8'd106; train_data[64][2]=8'd228; train_data[64][3]=8'd234; train_labels[64]=2'd2;
        train_data[65][0]=8'd90; train_data[65][1]=8'd53; train_data[65][2]=8'd134; train_data[65][3]=8'd128; train_labels[65]=2'd1;
        train_data[66][0]=8'd8; train_data[66][1]=8'd96; train_data[66][2]=8'd18; train_data[66][3]=8'd11; train_labels[66]=2'd0;
        train_data[67][0]=8'd0; train_data[67][1]=8'd106; train_data[67][2]=8'd4; train_data[67][3]=8'd0; train_labels[67]=2'd0;
        train_data[68][0]=8'd128; train_data[68][1]=8'd21; train_data[68][2]=8'd179; train_data[68][3]=8'd149; train_labels[68]=2'd2;
        train_data[69][0]=8'd217; train_data[69][1]=8'd128; train_data[69][2]=8'd224; train_data[69][3]=8'd181; train_labels[69]=2'd2;
        train_data[70][0]=8'd22; train_data[70][1]=8'd117; train_data[70][2]=8'd22; train_data[70][3]=8'd11; train_labels[70]=2'd0;
        train_data[71][0]=8'd60; train_data[71][1]=8'd159; train_data[71][2]=8'd18; train_data[71][3]=8'd21; train_labels[71]=2'd0;
        train_data[72][0]=8'd8; train_data[72][1]=8'd106; train_data[72][2]=8'd13; train_data[72][3]=8'd11; train_labels[72]=2'd0;
        train_data[73][0]=8'd150; train_data[73][1]=8'd53; train_data[73][2]=8'd174; train_data[73][3]=8'd149; train_labels[73]=2'd1;
        train_data[74][0]=8'd150; train_data[74][1]=8'd149; train_data[74][2]=8'd206; train_data[74][3]=8'd244; train_labels[74]=2'd2;
        train_data[75][0]=8'd22; train_data[75][1]=8'd149; train_data[75][2]=8'd18; train_data[75][3]=8'd21; train_labels[75]=2'd0;
        train_data[76][0]=8'd187; train_data[76][1]=8'd106; train_data[76][2]=8'd201; train_data[76][3]=8'd213; train_labels[76]=2'd2;
        train_data[77][0]=8'd150; train_data[77][1]=8'd138; train_data[77][2]=8'd224; train_data[77][3]=8'd255; train_labels[77]=2'd2;
        train_data[78][0]=8'd30; train_data[78][1]=8'd128; train_data[78][2]=8'd13; train_data[78][3]=8'd11; train_labels[78]=2'd0;
        train_data[79][0]=8'd135; train_data[79][1]=8'd96; train_data[79][2]=8'd166; train_data[79][3]=8'd138; train_labels[79]=2'd1;
        train_data[80][0]=8'd165; train_data[80][1]=8'd85; train_data[80][2]=8'd161; train_data[80][3]=8'd149; train_labels[80]=2'd1;
        train_data[81][0]=8'd142; train_data[81][1]=8'd85; train_data[81][2]=8'd170; train_data[81][3]=8'd181; train_labels[81]=2'd2;
        train_data[82][0]=8'd203; train_data[82][1]=8'd128; train_data[82][2]=8'd166; train_data[82][3]=8'd138; train_labels[82]=2'd1;
        train_data[83][0]=8'd158; train_data[83][1]=8'd128; train_data[83][2]=8'd192; train_data[83][3]=8'd234; train_labels[83]=2'd2;
        train_data[84][0]=8'd60; train_data[84][1]=8'd191; train_data[84][2]=8'd27; train_data[84][3]=8'd11; train_labels[84]=2'd0;
        train_data[85][0]=8'd195; train_data[85][1]=8'd117; train_data[85][2]=8'd197; train_data[85][3]=8'd213; train_labels[85]=2'd2;
        train_data[86][0]=8'd120; train_data[86][1]=8'd106; train_data[86][2]=8'd143; train_data[86][3]=8'd149; train_labels[86]=2'd1;
        train_data[87][0]=8'd165; train_data[87][1]=8'd106; train_data[87][2]=8'd188; train_data[87][3]=8'd202; train_labels[87]=2'd2;
        train_data[88][0]=8'd105; train_data[88][1]=8'd64; train_data[88][2]=8'd112; train_data[88][3]=8'd96; train_labels[88]=2'd1;
        train_data[89][0]=8'd68; train_data[89][1]=8'd74; train_data[89][2]=8'd130; train_data[89][3]=8'd138; train_labels[89]=2'd1;
        train_data[90][0]=8'd135; train_data[90][1]=8'd106; train_data[90][2]=8'd161; train_data[90][3]=8'd138; train_labels[90]=2'd1;
        train_data[91][0]=8'd15; train_data[91][1]=8'd32; train_data[91][2]=8'd13; train_data[91][3]=8'd21; train_labels[91]=2'd0;
        train_data[92][0]=8'd172; train_data[92][1]=8'd96; train_data[92][2]=8'd161; train_data[92][3]=8'd128; train_labels[92]=2'd1;
        train_data[93][0]=8'd90; train_data[93][1]=8'd64; train_data[93][2]=8'd152; train_data[93][3]=8'd117; train_labels[93]=2'd1;
        train_data[94][0]=8'd75; train_data[94][1]=8'd181; train_data[94][2]=8'd22; train_data[94][3]=8'd11; train_labels[94]=2'd0;
        train_data[95][0]=8'd98; train_data[95][1]=8'd106; train_data[95][2]=8'd139; train_data[95][3]=8'd128; train_labels[95]=2'd1;
        train_data[96][0]=8'd225; train_data[96][1]=8'd96; train_data[96][2]=8'd237; train_data[96][3]=8'd181; train_labels[96]=2'd2;
        train_data[97][0]=8'd180; train_data[97][1]=8'd138; train_data[97][2]=8'd210; train_data[97][3]=8'd213; train_labels[97]=2'd2;
        train_data[98][0]=8'd60; train_data[98][1]=8'd181; train_data[98][2]=8'd22; train_data[98][3]=8'd32; train_labels[98]=2'd0;
        train_data[99][0]=8'd45; train_data[99][1]=8'd42; train_data[99][2]=8'd103; train_data[99][3]=8'd96; train_labels[99]=2'd1;
        train_data[100][0]=8'd180; train_data[100][1]=8'd138; train_data[100][2]=8'd210; train_data[100][3]=8'd255; train_labels[100]=2'd2;
        train_data[101][0]=8'd217; train_data[101][1]=8'd106; train_data[101][2]=8'd215; train_data[101][3]=8'd159; train_labels[101]=2'd2;
        train_data[102][0]=8'd45; train_data[102][1]=8'd170; train_data[102][2]=8'd18; train_data[102][3]=8'd0; train_labels[102]=2'd0;
        train_data[103][0]=8'd180; train_data[103][1]=8'd117; train_data[103][2]=8'd206; train_data[103][3]=8'd244; train_labels[103]=2'd2;
        train_data[104][0]=8'd45; train_data[104][1]=8'd106; train_data[104][2]=8'd18; train_data[104][3]=8'd11; train_labels[104]=2'd0;
        train_data[105][0]=8'd195; train_data[105][1]=8'd117; train_data[105][2]=8'd174; train_data[105][3]=8'd149; train_labels[105]=2'd1;
        train_data[106][0]=8'd233; train_data[106][1]=8'd85; train_data[106][2]=8'd228; train_data[106][3]=8'd191; train_labels[106]=2'd2;
        train_data[107][0]=8'd150; train_data[107][1]=8'd96; train_data[107][2]=8'd206; train_data[107][3]=8'd181; train_labels[107]=2'd2;
        train_data[108][0]=8'd105; train_data[108][1]=8'd85; train_data[108][2]=8'd139; train_data[108][3]=8'd128; train_labels[108]=2'd1;
        train_data[109][0]=8'd165; train_data[109][1]=8'd106; train_data[109][2]=8'd201; train_data[109][3]=8'd181; train_labels[109]=2'd2;
        train_data[110][0]=8'd150; train_data[110][1]=8'd32; train_data[110][2]=8'd152; train_data[110][3]=8'd128; train_labels[110]=2'd1;
        train_data[111][0]=8'd158; train_data[111][1]=8'd96; train_data[111][2]=8'd148; train_data[111][3]=8'd128; train_labels[111]=2'd1;
        train_data[112][0]=8'd98; train_data[112][1]=8'd85; train_data[112][2]=8'd174; train_data[112][3]=8'd202; train_labels[112]=2'd2;
        train_data[113][0]=8'd120; train_data[113][1]=8'd106; train_data[113][2]=8'd183; train_data[113][3]=8'd181; train_labels[113]=2'd2;
        train_data[114][0]=8'd83; train_data[114][1]=8'd149; train_data[114][2]=8'd31; train_data[114][3]=8'd11; train_labels[114]=2'd0;
        train_data[115][0]=8'd135; train_data[115][1]=8'd85; train_data[115][2]=8'd134; train_data[115][3]=8'd128; train_labels[115]=2'd1;
        train_data[116][0]=8'd45; train_data[116][1]=8'd53; train_data[116][2]=8'd157; train_data[116][3]=8'd170; train_labels[116]=2'd2;
        train_data[117][0]=8'd112; train_data[117][1]=8'd212; train_data[117][2]=8'd9; train_data[117][3]=8'd11; train_labels[117]=2'd0;
        train_data[118][0]=8'd112; train_data[118][1]=8'd64; train_data[118][2]=8'd134; train_data[118][3]=8'd117; train_labels[118]=2'd1;
        train_data[119][0]=8'd210; train_data[119][1]=8'd106; train_data[119][2]=8'd219; train_data[119][3]=8'd213; train_labels[119]=2'd2;
    end

    // 120 parallel distance calculators 
  
    genvar gi;
    generate
        for (gi = 0; gi < 120; gi = gi + 1) begin : dist_units
            dist_calc u (
                .A1(test0), .A2(test1), .A3(test2), .A4(test3),
                .B1(train_data[gi][0]), .B2(train_data[gi][1]),
                .B3(train_data[gi][2]), .B4(train_data[gi][3]),
                .D(dist_out[gi])           
            );
        end
    endgenerate

    // k=3 nearest-neighbour vote 
   
    reg [9:0] min_dist  [0:2];
    reg [1:0] min_label [0:2];
    reg [9:0] temp_dist [0:119];
    integer   ii, jj;          

    always @(*) begin
        // copy distances into mutable temp array
        for (ii = 0; ii < 120; ii = ii + 1)
            temp_dist[ii] = dist_out[ii];   

        // ── find 1st nearest ──
        min_dist[0]  = 10'h3FF;
        min_label[0] = 2'd0;
        for (ii = 0; ii < 120; ii = ii + 1)
            if (temp_dist[ii] < min_dist[0]) begin
                min_dist[0]  = temp_dist[ii];
                min_label[0] = train_labels[ii];
            end
        for (ii = 0; ii < 120; ii = ii + 1)
            if (temp_dist[ii] == min_dist[0]) temp_dist[ii] = 10'h3FF;

        // ── find 2nd nearest ──
        min_dist[1]  = 10'h3FF;
        min_label[1] = 2'd0;
        for (ii = 0; ii < 120; ii = ii + 1)
            if (temp_dist[ii] < min_dist[1]) begin
                min_dist[1]  = temp_dist[ii];
                min_label[1] = train_labels[ii];
            end
        for (ii = 0; ii < 120; ii = ii + 1)
            if (temp_dist[ii] == min_dist[1]) temp_dist[ii] = 10'h3FF;

        // ── find 3rd nearest ──
        min_dist[2]  = 10'h3FF;
        min_label[2] = 2'd0;
        for (ii = 0; ii < 120; ii = ii + 1)
            if (temp_dist[ii] < min_dist[2]) begin
                min_dist[2]  = temp_dist[ii];
                min_label[2] = train_labels[ii];
            end

        // ── majority vote ──
        jj = 0;
        if (min_label[0] == 2'd0) jj = jj + 1;
        if (min_label[1] == 2'd0) jj = jj + 1;
        if (min_label[2] == 2'd0) jj = jj + 1;
        if (jj >= 2) begin
            predicted_class = 2'd0;
        end else begin
            jj = 0;
            if (min_label[0] == 2'd1) jj = jj + 1;
            if (min_label[1] == 2'd1) jj = jj + 1;
            if (min_label[2] == 2'd1) jj = jj + 1;
            if (jj >= 2)
                predicted_class = 2'd1;
            else
                predicted_class = 2'd2;
        end
    end

endmodule