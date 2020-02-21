#include "parser.h"
#include <iostream>
using namespace std;

vector<string> parse_frdic_conj(string s)
{
    vector<string> result(_SIZE);

    regex reg("<table class=\"table-col-2\">.*</table>");
    smatch p1, p2;
    regex_search(s, p1, reg);
    string tmp = p1.str();
    regex_search(tmp, p2, reg.assign("<td>.*</td><td>.*</td>"));
    string participe = p2.str();
    regex tag("<.*?>");
    participe = regex_replace(participe, tag, "\t");
    stringstream ss(participe);
    ss >> tmp;
    result[ParPresent] = tmp;
    ss >> tmp;
    result[ParPasse] = tmp;

    reg.assign("<table class=\"table-col-4\">.*?</table>");
    smatch useful_div, inner;
    string s1 = s;
    int iteration = 0;
    while (regex_search(s1, useful_div, reg) && iteration != 4)
    {
        string r1 = useful_div.str(); //should write before the next line
        s1 = useful_div.suffix().str();
        regex tr("<td>.+?</td>");
        int inner_count = 0;
        while (regex_search(r1, inner, tr))
        {
            tmp = inner.str();
            r1 = inner.suffix().str();
            int index1 = tmp.find(">") + 1; //remove <td> </td>
            int index2 = tmp.find_last_of("<");
            //cout << tmp.substr(index1, index2 - index1)<<"\n";
            result[IndiPresent + inner_count % 4 + iteration * 4] += tmp.substr(index1, index2 - index1) + "\n";
            inner_count++;
        }
        iteration++;
    }

    return result;
}

vector<string> parse_frdic_mean(string s)
{
    vector<string> meaning(_SIZE);
    regex reg("<span class=exp>.*?</span><!--/exp-->");
    smatch re;
    string tmp;
    while (regex_search(s, re, reg))
    {
        tmp = re.str();
        s = re.suffix().str();
        regex tag("<.*?>");
        tmp = regex_replace(tmp, tag, "");
        meaning[0] += tmp + "\n";
    }
    return meaning;
}

vector<string> parse_frdic(string s, TYPE t)
{
    switch (t)
    {
    case CONJ:
        return parse_frdic_conj(s);
        break;
    case MEAN:
        return parse_frdic_mean(s);
        break;
    }
}