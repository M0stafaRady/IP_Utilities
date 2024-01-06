/*
	Copyright 2020 AUCOHL

    Author: Mohamed Shalan (mshalan@aucegypt.edu)
	
	Licensed under the Apache License, Version 2.0 (the "License"); 
	you may not use this file except in compliance with the License. 
	You may obtain a copy of the License at:

	http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software 
	distributed under the License is distributed on an "AS IS" BASIS, 
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
	See the License for the specific language governing permissions and 
	limitations under the License.
*/

task AHB_READ (input [2:0] size, input [31:0] addr, output [31:0] data);
    begin : task_body
        wait (HREADY == 1'b1);
        @(posedge HCLK);
        #1;
        HTRANS  = 2'b10;
        HWRITE  = 1'b0;
        HADDR   = addr;
        HSIZE   = size;
        @(posedge HCLK);
        #1;
        HTRANS  = 2'b00;
        wait (HREADY == 1'b1);
        @(posedge HCLK) data = HRDATA;
    end
endtask

task AHB_WRITE(input [2:0] size, input [31:0] addr, input [31:0] data);
    begin : task_body
        wait (HREADY == 1'b1);
        @(posedge HCLK);
        #1;
        HTRANS  = 2'b10;
        HWRITE  = 1'b1;
        HADDR   = ADDR;
        HSIZE   = size;
        @(posedge HCLK);
        #1;
        HTRANS  = 2'b00;;
        HWDATA  = data;
        #1;
        wait(HREADY);
    end
endtask