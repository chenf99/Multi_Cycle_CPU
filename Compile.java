import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;


public class Compile {
	public static void main(String[] argv) throws Exception {
		FileInputStream in = new FileInputStream("program.txt");
		InputStreamReader fsr = new InputStreamReader(in, "UTF-8");
		BufferedReader br = new BufferedReader(fsr);
		FileOutputStream out = new FileOutputStream("instructions.txt");
		OutputStreamWriter osw = new OutputStreamWriter(out, "UTF-8");
		BufferedWriter bw = new BufferedWriter(osw);
		String line;
		String op, opcode, rs, rt, rd, imme, addr;
		String reserved = "00000000000";
		String sa;
		int temp;
		while ((line = br.readLine()) != null) {
			//停机指令时退出循环
			if (line.equals("halt")) {
				bw.write("11111100 00000000 00000000 00000000");break;
			}
			String result = "";
			op = line.substring(0, line.indexOf(' '));//得到对应操作 
			switch (op) {
				//后接形式为rd, rs, rt的指令
				case "add":
				case "sub":
				case "or":
				case "and":
				case "slt":
					if (op.equals("add")) opcode = "000000";
					else if (op.equals("sub")) opcode = "000001";
					else if (op.equals("or")) opcode = "010000";
					else if (op.equals("and")) opcode = "010001";
					else opcode = "100110";
					rd = line.substring(line.indexOf('$') + 1, line.indexOf(','));
					temp = Integer.parseInt(rd);
					rd = Integer.toBinaryString(temp);
					//不足5位的补0
					rd = String.format("%05d", Integer.parseInt(rd));
					
					line = line.substring(line.indexOf(',') + 2);
					rs = line.substring(0, line.indexOf(','));
					temp = Integer.parseInt(rs);
					rs = Integer.toBinaryString(temp);
					//不足5位的补0
					rs = String.format("%05d", Integer.parseInt(rs));
					
					line = line.substring(line.indexOf(',') + 2);
					rt = line;
					temp = Integer.parseInt(rt);
					rt = Integer.toBinaryString(temp);
					rt = String.format("%05d", Integer.parseInt(rt));
					result = opcode + rs + rt + rd + reserved;
					break;
				//后接rt，rs，immediate的指令
				case "addi":
				case "ori":
				case "sltiu":
					if (op.equals("addi")) opcode = "000010";
					else if (op.equals("ori")) opcode = "010010";
					else opcode = "100111";
					rt = line.substring(line.indexOf('$') + 1, line.indexOf(','));
					temp = Integer.parseInt(rt);
					rt = Integer.toBinaryString(temp);
					//不足5位的补0
					rt = String.format("%05d", Integer.parseInt(rt));
					
					line = line.substring(line.indexOf(',') + 2);
					rs = line.substring(0, line.indexOf(','));
					temp = Integer.parseInt(rs);
					rs = Integer.toBinaryString(temp);
					//不足5位的补0
					rs = String.format("%05d", Integer.parseInt(rs));
					
					line = line.substring(line.indexOf(',') + 1);
					imme = line;
					temp = Integer.parseInt(imme);
					imme = Integer.toBinaryString(temp);
					if (temp < 0) imme = imme.substring(16);
					else imme = String.format("%016d", Integer.parseInt(imme));
					result = opcode + rs + rt + imme;
					break;
				//后接rs，rt，immediate的指令 
				case "beq":
					opcode = "110100";
					rs = line.substring(line.indexOf('$') + 1, line.indexOf(','));
					temp = Integer.parseInt(rs);
					rs = Integer.toBinaryString(temp);
					//不足5位的补0
					rs = String.format("%05d", Integer.parseInt(rs));
					
					line = line.substring(line.indexOf(',') + 2);
					rt = line.substring(0, line.indexOf(','));
					temp = Integer.parseInt(rt);
					rt = Integer.toBinaryString(temp);
					//不足5位的补0
					rt = String.format("%05d", Integer.parseInt(rt));
					
					line = line.substring(line.indexOf(',') + 1);
					imme = line;
					temp = Integer.parseInt(imme);
					imme = Integer.toBinaryString(temp).substring(16);
					result = opcode + rs + rt + imme;
					break;
				//后接rt, imme(rs)的指令
				case "sw":
				case "lw":
					if (op.equals("sw")) opcode = "110000";
					else opcode = "110001";
					rt = line.substring(line.indexOf('$') + 1, line.indexOf(','));
					temp = Integer.parseInt(rt);
					rt = Integer.toBinaryString(temp);
					//不足5位的补0
					rt = String.format("%05d", Integer.parseInt(rt));
					
					line = line.substring(line.indexOf(',') + 1);
					imme = line.substring(0, line.indexOf('('));
					temp = Integer.parseInt(imme);
					imme = Integer.toBinaryString(temp);
					//不足5位的补0
					imme = String.format("%016d", Integer.parseInt(imme));
					
					line = line.substring(line.indexOf('(') + 2);
					rs = line.substring(0, line.indexOf(')'));
					temp = Integer.parseInt(rs);
					rs = Integer.toBinaryString(temp);
					//不足5位的补0
					rs = String.format("%05d", Integer.parseInt(rs));
					result = opcode + rs + rt + imme;
					break;
				case "sll":
					opcode = "011000";
					rd = line.substring(line.indexOf('$') + 1, line.indexOf(','));
					temp = Integer.parseInt(rd);
					rd = Integer.toBinaryString(temp);
					//不足5位的补0
					rd = String.format("%05d", Integer.parseInt(rd));
					
					line = line.substring(line.indexOf(',') + 2);
					rt = line.substring(0, line.indexOf(','));
					temp = Integer.parseInt(rt);
					rt = Integer.toBinaryString(temp);
					//不足5位的补0
					rt = String.format("%05d", Integer.parseInt(rt));
					
					line = line.substring(line.indexOf(',') + 1);
					sa = line;
					temp = Integer.parseInt(sa);
					sa = Integer.toBinaryString(temp);
					sa = String.format("%05d", Integer.parseInt(sa));
					result = opcode + "00000" + rt + rd + sa + "000000";
					break;
				case "bltz":
					opcode = "110110";
					rs = line.substring(line.indexOf('$') + 1, line.indexOf(','));
					temp = Integer.parseInt(rs);
					rs = Integer.toBinaryString(temp);
					//不足5位的补0
					rs = String.format("%05d", Integer.parseInt(rs));
					
					line = line.substring(line.indexOf(',') + 1);
					imme = line;
					temp = Integer.parseInt(imme);
					imme = Integer.toBinaryString(temp).substring(16);
					result = opcode + rs + "00000" + imme;
					break;
				case "j":
				case "jal":
					if (op.equals("j")) result = "11100000000000000000000000010011";
					else result = "11101000000000000000000000010000";
					break;
				case "jr":
					result = "11100111111000000000000000000000";
					break;
				default:break;
			}
			//插入空格
			if (result.equals("")) continue;
			StringBuilder sb = new StringBuilder(result);
			sb.insert(8, ' ');
			sb.insert(17, ' ');
			sb.insert(26, ' ');
			bw.write(sb.toString());
			bw.newLine();
		}
		br.close();
		fsr.close();
		in.close();
		bw.close();
		osw.close();
		out.close();
	}
}
