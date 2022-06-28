using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace METRICS_DKA {
    class Program {

        enum States { Start, Def, Qualifier, Id, Type }

        private const int PADDING = 25;
        static string code;
        static Dictionary<string, int> operators = new Dictionary<string, int>();
        static Dictionary<string, int> operands = new Dictionary<string, int>();
        static List<string> tokens = new List<string>();
        static void CleanWhiteSpaces() {
            code = Regex.Replace(code, @"^\s*", "", RegexOptions.Multiline);
            code = Regex.Replace(code, @" +", " ");
        }
        static void ClearDirectivesAndComments() {
            string regDirectives = @"(#|using).*";
            code = Regex.Replace(code, regDirectives, "");
            string regComments = @"\/\/.*";
            code = Regex.Replace(code, regComments, "");
        }
        static void ConsiderOperator(string s) {
            if (operators.ContainsKey(s))
                operators[s]++;
            else
                operators.Add(s, 1);
        }
        static void ConsiderOperand(string s) {
            if (operands.ContainsKey(s))
                operands[s]++;
            else
                operands.Add(s, 1);
        }
        static void AddToken(ref string s) {
            if (s.Length > 0) {
                tokens.Add(s);
                s = "";
            }
        }
        static void Main(string[] args) {
            StreamReader file = new StreamReader("input.txt");
            code = file.ReadToEnd();
            file.Close();
            CleanWhiteSpaces(); //GOOD
            ClearDirectivesAndComments(); //GOOD
            //TOKENIZE
            int i = 0;
            string token = "";
            List<string> ops = new List<string> { @"==", @"!=", @"++", @"+=", @"--", @"-=", @"->*", @"->", @".*", @".", @",", @"sizeof", @"alignof", @"typeid", @"new", @"delete", @"::", @"-", @"**", @"*=", @"/=", @"/", @"%=", @"%", @"+", @"*", @"=", @">=", @"<=", @">>=", @">>", @">", @"<<=", @"<<", @"<", @"!", @"&&", @"&=", @"&", @"", @"", @"", @"", @"=", @"", @"~", @"^=", @"^", @"{", @"}", @"(", @")", @"[", @"]", "return" }; // ";" - is punctuator
            List<string> simpleTypes = new List<string> { "int", "char", "bool", "string", "void", "float", "double" };
            List<string> containers = new List<string> { "vector", "map", "set", "queue", "dequeue", "stack", "list", "array", "multi_map", "priority_queue" };
            List<string> qualifiers = new List<string> { "const", "unsigned", "short", "long", "volatile" };
            while (i < code.Length) {
                if (i + 1 < code.Length && ops.Contains(code[i].ToString() + code[i + 1].ToString())) {
                    AddToken(ref token);
                    tokens.Add(code[i].ToString() + code[i + 1].ToString());
                    i++;
                }
                else if (ops.Contains(code[i].ToString())) {
                    AddToken(ref token);
                    tokens.Add(code[i].ToString());
                }
                else if (Char.IsWhiteSpace(code[i])) {
                    AddToken(ref token);
                }
                else if (code[i] == '"') {
                    token = "\"";
                    i++;
                    while (code[i] != '"') {
                        token += code[i];
                        i++;
                    }
                    token += '"';
                    AddToken(ref token);
                }
                else {
                    token += code[i];
                }
                i++;
            }
            //ANALYSE
            i = 0;
            States state = States.Start;
            while (i < tokens.Count) {
                switch (state) {
                    case States.Start:
                        token = tokens[i];
                        //IS TYPE
                        if (simpleTypes.Contains(token) || containers.Contains(tokens[i])) {
                            state = States.Type;
                        }
                        else if (qualifiers.Contains(token)) {
                            state = States.Type;
                        }
                        else if (ops.Contains(tokens[i])) {
                            ConsiderOperator(tokens[i]);
                            if (tokens[i] == "[" || tokens[i] == "(") {
                                state = States.Start;
                            }
                            else if (tokens[i] == ";") {
                                state = States.Start;
                            }
                            i++;
                        }
                        else {
                            state = States.Id;
                        }
                        break;
                    case States.Id:
                        string id = tokens[i];
                        if (i + 1 < tokens.Count && tokens[i + 1] == "(") {
                            if(id == "if" || id == "while" || id == "for" || id == "switch" || id == "while")
                                ConsiderOperator(id);
                            i += 2;
                            state = States.Start;
                        }
                        else {
                            ConsiderOperand(id);
                            i++;
                            state = States.Start;
                        }
                        break;
                    case States.Type:
                        if (containers.Contains(tokens[i])) {
                            int delta = 1;
                            i += 2;
                            while (delta != 0) {
                                if (tokens[i] == ">" || tokens[i] == ">>") {
                                    delta -= tokens[i].Length;
                                }
                                else if (tokens[i] == "<" || tokens[i] == "<") {
                                    delta += tokens[i].Length;
                                }
                                i++;
                            }
                        }
                        else if (simpleTypes.Contains(tokens[i])) {
                            i++;
                        }
                        state = States.Id;
                        break;
                }
            }

            //PRINT STATS
            StreamWriter outFile = new StreamWriter("output.txt");


            //####################################VISUAL####################################
            int n1 = 0, N1 = 0;
            outFile.WriteLine("---------STATS------------>");
            foreach (KeyValuePair<string, int> op in operators) {
                if (op.Key == "(" || op.Key == "[" || op.Key == "{") {
                    if (op.Key == "[")
                        outFile.Write("[]".PadRight(PADDING));
                    else if (op.Key == "(")
                        outFile.Write("()".PadRight(PADDING));
                    else
                        outFile.Write("{}".PadRight(PADDING));
                    outFile.WriteLine(op.Value);
                    n1++;
                    N1 += op.Value;
                }
                else if (!ops.Contains(op.Key)) {
                    outFile.Write((@op.Key + "()").PadRight(PADDING));
                    outFile.WriteLine(op.Value);
                    n1++;
                    N1 += op.Value;
                }
                else if (op.Key != ")" && op.Key != "]" && op.Key != "}") {
                    outFile.Write(@op.Key.PadRight(PADDING));
                    outFile.WriteLine(op.Value);
                    n1++;
                    N1 += op.Value;
                }
            }
            outFile.WriteLine("-------------------------->");
            outFile.WriteLine("TOTAL: " + N1.ToString());
            outFile.WriteLine();
            //####################################VISUAL####################################
            //foreach (KeyValuePair<string, int> op in operators) {
                //if (op.Key == "(" || op.Key == "[" || op.Key == "{") {
                    //N1 += op.Value;
                //}
                //else if (!ops.Contains(op.Key)) {
                   // N1 += op.Value;
                //}
                //else if (op.Key != ")" && op.Key != "]" && op.Key != "}") {
                    //N1 += op.Value;
                //}
            //}
            int nOfOperands = N1;

            int conditionals = 0; //CL
            conditionals += tokens.Count(s => ("if" == s));
            conditionals += tokens.Count(s => ("while" == s));
            conditionals += tokens.Count(s => ("for" == s));
            conditionals += tokens.Count(s => ("case" == s));
            outFile.WriteLine("CL: " + conditionals.ToString());
            outFile.WriteLine("cl: " + string.Format("{0:0.000}",(conditionals * 1.0 / N1)));
            

            int maxNesting = 0;
            int curNesting = 0;
            bool IsConditional(string op) {
                return op == "if" || op == "while" || op == "case" || op == "for";
            }
            Stack<string> st = new Stack<string>();
            for (i = 0; i < tokens.Count(); i++) {
                if (tokens[i] == "switch") {
                    st.Push(curNesting.ToString());
                    st.Push("switch");
                }
                else if (IsConditional(tokens[i])) {
                    curNesting++;
                    st.Push(tokens[i]);
                }
                else if (tokens[i] == "{" || tokens[i] == "(") {
                    st.Push(tokens[i]);
                }
                else if (tokens[i] == ")") {
                    st.Pop();
                }
                else if (tokens[i] == "}") {
                    st.Pop();
                    if (st.Count() != 0) {
                        if (st.Peek() == "switch") {
                            st.Pop();
                            curNesting = Int32.Parse(st.Pop());
                        }
                        else {
                            while (st.Count() != 0 && IsConditional(st.Peek())) {
                                if (st.Pop() != "case")
                                    curNesting--;
                            }
                        }
                    }
                }
                else if (tokens[i] == ";") {
                    while (st.Count() != 0 && IsConditional(st.Peek())) {
                        string op = st.Pop();
                        if (op != "case")
                            curNesting--;
                    }
                }
                maxNesting = Math.Max(maxNesting, curNesting);
            }
            maxNesting--;

            outFile.WriteLine("CLI: " + maxNesting.ToString());
            outFile.Close();
        }
    }
}