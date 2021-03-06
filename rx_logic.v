module rx_logic(item_out, write, full, 
		n_valid, n_item, n_read, 
		s_valid, s_item, s_read, 
		e_valid, e_item, e_read, 
		w_valid, w_item, w_read, 
		l_valid, l_item, l_read,
		);

	input full;
	
	input n_valid, s_valid, e_valid, w_valid, l_valid;
	
	output n_read, s_read, e_read, w_read, l_read;
	
	output write;
	
	input [`SIZE-1:0] n_item;
	input [`SIZE-1:0] s_item;
	input [`SIZE-1:0] e_item;
	input [`SIZE-1:0] w_item;
	input [`SIZE-1:0] l_item;
	
	output [`SIZE-1:0] item_out;
	
	wire n_sel, s_sel, e_sel, w_sel, l_sel;
	
	assign n_sel = n_valid;
	assign s_sel = !n_valid & s_valid;
	assign e_sel = !n_valid & !s_valid & e_valid;
	assign w_sel = !n_valid & !s_valid & !e_valid & w_valid;
	assign l_sel = !n_valid & !s_valid & !e_valid & !w_valid & l_valid;
	
	assign n_read = !full & n_sel;
	assign s_read = !full & s_sel;
	assign e_read = !full & e_sel;
	assign w_read = !full & w_sel;
	assign l_read = !full & l_sel;
	
	assign item_out = n_sel ? n_item : (s_sel ? s_item : (e_sel ? e_item : (w_sel?w_item:(l_item) )));
	
	assign write = n_read | s_read | e_read | w_read | l_read;

endmodule
