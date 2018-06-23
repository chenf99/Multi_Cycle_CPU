import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;


public class Compile {
	//因为Java的String类作为参数只能是值传递，那我只能把它们都写为成员了
	//静态函数只能调用静态成员和静态方法
	private static String op, r1, r2, r3, imme;
	
	//把输入的10进制字符串转为5位2进制字符串并补0
	private static String change2Binary5(String input) {
		input = Integer.toBinaryString(Integer.parseInt(input));
		input = String.format("%05d", Integer.parseInt(input));//不足5位的补0
		return input;
	}
	
	//把输入的10进制字符串转为16位2进制字符串并补0
	private static String change2Binary16(String input) {
		int temp = Integer.parseInt(input);
		input = Integer.toBinaryString(temp);
		if (temp < 0) input = input.substring(16);
		else input = String.format("%016d", Integer.parseInt(input));
		return input;
	}
	
	//分割指令，得到rs、rt等
	private static void parse(String line) {
		op = line.substring(0, line.indexOf(' '));
		//后面接的不是r1, r2, imme或者r1, r2, r3形式
		if (op.equals("jal") || op.equals("j") || op.equals("sw") || op.equals("jr") || op.equals("lw") || op.equals("bltz")) {
			
		}
		else {
			r1 = line.substring(line.indexOf('$') + 1, line.indexOf(','));
			line = line.substring(line.indexOf(',') + 2);
			r2 = line.substring(0, line.indexOf(','));
			imme = line.substring(line.indexOf(',') + 1);
			r3 = line.substring(line.indexOf(',') + 2);
			
			r1 = change2Binary5(r1);
			r2 = change2Binary5(r2);
			if (!r3.equals("")) r3 = change2Binary5(r3);
			
			if (imme.indexOf('$') == -1) {
				//把得到的立即数转为16位2进制字符串或者5位2进制字符串
				if (op.equals("sll")) imme = change2Binary5(imme);
				else imme = change2Binary16(imme);
			}
		}
	}
	public static void main(String[] argv) throws Exception {
		FileInputStream in = new FileInputStream("program.txt");
		InputStreamReader fsr = new InputStreamReader(in, "UTF-8");
		BufferedReader br = new BufferedReader(fsr);
		FileOutputStream out = new FileOutputStream("instructions.txt");
		OutputStreamWriter osw = new OutputStreamWriter(out, "UTF-8");
		BufferedWriter bw = new BufferedWriter(osw);
		String line;//每一行的指令
		String reserved = "00000000000";
		String opcode, rs, rt, rd, immediate, sa, addr;
		int temp;
		while ((line = br.readLine()) != null) {
			//停机指令时退出循环,因此不会导致parse函数抛出异常
			if (line.equals("halt")) {
				bw.write("11111100 00000000 00000000 00000000");break;
			}
			String result = "";
			parse(line);
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
					rd = r1;
					rs = r2;
					rt = r3;
					result = opcode + rs + rt + rd + reserved;
					break;
				//后接rt，rs，immediate的指令
				case "addi":
				case "ori":
				case "sltiu":
					if (op.equals("addi")) opcode = "000010";
					else if (op.equals("ori")) opcode = "010010";
					else opcode = "100111";
					rt = r1;
					rs = r2;
					immediate = imme;
					result = opcode + rs + rt + immediate;
					break;
				//后接rs，rt，immediate的指令 
				case "beq":
					opcode = "110100";
					rs = r1;
					rt = r2;
					immediate = imme;
					result = opcode + rs + rt + immediate;
					break;
				//后接rt, imme(rs)的指令
				case "sw":
				case "lw":
					if (op.equals("sw")) opcode = "110000";
					else opcode = "110001";
					rt = line.substring(line.indexOf('$') + 1, line.indexOf(','));
					rt = change2Binary5(rt);
					line = line.substring(line.indexOf(',') + 1);
					immediate = line.substring(0, line.indexOf('('));
					immediate = change2Binary16(immediate);
					line = line.substring(line.indexOf('(') + 2);
					rs = line.substring(0, line.indexOf(')'));
					rs = change2Binary5(rs);
					result = opcode + rs + rt + immediate;
					break;
				//后接rd, rt, sa
				case "sll":
					opcode = "011000";
					rd = r1;
					rt = r2;
					sa = imme;
					result = opcode + "00000" + rt + rd + sa + "000000";
					break;
				case "bltz":
					opcode = "110110";
					rs = line.substring(line.indexOf('$') + 1, line.indexOf(','));
					rs = change2Binary5(rs);
					immediate = line.substring(line.indexOf(',') + 1);
					immediate = change2Binary16(immediate);
					result = opcode + rs + "00000" + immediate;
					break;
				case "j":
				case "jal":
					if (op.equals("j")) opcode = "111000";
					else opcode = "111010";
					addr = line.substring(line.indexOf('x') + 1);
					addr.toUpperCase();
					temp = 0;
					char[] c = addr.toCharArray();
					//把地址转为10进制
					for (int i = 0; i < addr.length(); ++i) {
						if (c[i] > '9') c[i] -= 7;
						temp += (c[i] - '0') * Math.pow(16, addr.length() - 1 - i);
					}
					addr = change2Binary16(String.valueOf(temp));
					addr = "00" + addr.substring(0, 14);
					result = opcode + "00000" + "00000" + addr;
					break;
				case "jr":
					opcode = "111001";
					rs = line.substring(line.indexOf('$') + 1);
					rs = change2Binary5(rs);
					result = opcode + rs + "00000" + "00000" + reserved;
					break;
				default:break;
			}
			//插入空格
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
