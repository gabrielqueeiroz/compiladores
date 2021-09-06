#include<iostream>
#include<cmath>
#include<stdio.h>
#include<cstdlib>
#include<map>
#include<stack>
#include <fstream>

using namespace std;

int expression_value(string str){
    map<char,int>priority;
    priority['^']=3;
    priority['*']=2,priority['/']=2;
    priority['+']=1,priority['-']=1;

    stack<char>op_stack;
    stack<int>val_stack;

    int val=0;
    for(int i=0;str[i];i++)
    {
        if(str[i]>='0'&&str[i]<='9')
          val=val*10+str[i]-'0';
        else
        {
            if(op_stack.empty())
            {
                val_stack.push(val);
                op_stack.push(str[i]);
            }
            else if(priority[op_stack.top()] < priority[str[i]])
            {
                val_stack.push(val);
                op_stack.push(str[i]);
            }
            else
            {
                int num1,num2;
                num1=val_stack.top(); val_stack.pop();
                num2=val;
                if(op_stack.top()=='+')
                  val_stack.push(num1 + num2);
                else if(op_stack.top()=='-')
                  val_stack.push(num1 - num2);
                else if(op_stack.top()=='*')
                  val_stack.push(num1 * num2);
                else if(op_stack.top()=='/')
                  val_stack.push(num1 / num2);
                else
                  val_stack.push(pow(num1 , num2));
                op_stack.pop();
                op_stack.push(str[i]);
            }
            val=0;
        }
    }
    val_stack.push(val);

    while(!op_stack.empty())
    {
        int num1,num2;
        num2=val_stack.top(); val_stack.pop();
        num1=val_stack.top(); val_stack.pop();
        if(op_stack.top()=='+')
            val_stack.push(num1 + num2);
        else if(op_stack.top()=='-')
            val_stack.push(num1 - num2);
        else if(op_stack.top()=='*')
            val_stack.push(num1 * num2);
        else if(op_stack.top()=='/')
            val_stack.push(num1 / num2);
        else
            val_stack.push(pow(num1 , num2));
        op_stack.pop();
    }
    return val_stack.top();
}

int main(){
	char number[20];
	std::ifstream inFile;
	
	inFile.open("expressoes.txt");
	if(inFile.is_open()){
		while(inFile.getline(number, 20)){
		std::cout << expression_value(number) << std::endl;
		}
	}
	inFile.close(); 
}