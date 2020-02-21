#include "printer.h"
using namespace std;

void fb_printer::set_options(string s){
    if(s=="all"){
        for(bool &x : options)
            x = true;
    }
    else if(s=="ind"){
        options[IndiPresent] = options[IndiPasseCom] = options[IndiPasseAnt] \ 
        = options[IndiFuturSim] = options[IndiPlus] = options[IndiFuterAnt] \
        = options[IndiFuturSim] = options[IndiImpar] = true;
    }
    else if(s=="sub"){
        options[SubImpar] = options[SubPasse] = options[SubPlus] = options[SubPresent] = true;
    }
    else if(s=="con"){
        options[ConPasse] = options[ConPresent] = true;
    }
    else if(s=="imp"){
        options[ImpePasse] = options[ImpePresent] = true;
    }
    else if(s=="par"){
        options[ParPasse] = options[ParPresent] = true;
    }
    else 
        options[IndiPresent] = true;
}
void fb_printer::format(TYPE type)
{
    switch (type)
    {
    case CONJ:
        format_conj();
        break;
    case MEAN:
        contents = strs[0];
        break;
    }
}

void fb_printer::print(){
    cout << contents ;
    contents = "";
}

void fb_printer::print(ostream &dest)
{
    dest << contents;
    contents = "";
    if (typeid(dest) != typeid(cout))
    {
        ofstream &output = dynamic_cast<ofstream &>(dest);
        output.clear();
        output.close();
    }
}

void fb_printer::format_conj()
{

    contents =  "=======================\n";
    if (options[ParPresent] || options[ParPasse])
    {
        contents = contents + "分词\n"
           + "-----------------------\n"
           + "现在分词： " + strs[ParPresent] + "\n"
           + "过去分词： " + strs[ParPasse] + "\n"
           + "=======================\n";
    }
    if (options[IndiPresent])
    {
        contents = contents + "直陈式-现在时： \n"
           + "-----------------------\n"
           + strs[IndiPresent]
           + "=======================\n";
    }
    if (options[IndiPasseCom])
    {
        contents = contents + "直陈式-复合过去时： \n"
           + "-----------------------\n"
           + strs[IndiPasseCom]
           + "=======================\n";
    }
    if (options[IndiImpar])
    {
        contents = contents + "直陈式-未完成过去时： \n"
           + "-----------------------\n"
           + strs[IndiImpar]
           + "=======================\n";
    }
    if (options[IndiPlus])
    {
        contents = contents + "直陈式-愈过去时： \n"
           + "-----------------------\n"
           + strs[IndiPlus]
           + "=======================\n";
    }
    if (options[IndiPasseSim])
    {
        contents = contents + "直陈式-简答过去时： \n"
           + "-----------------------\n"
           + strs[IndiPasseSim]
           + "=======================\n";
    }
    if (options[IndiPasseAnt])
    {
        contents = contents + "直陈式-先过去时： \n"
           + "-----------------------\n"
           + strs[IndiPasseAnt]
           + "=======================\n";
    }
    if (options[IndiFuturSim])
    {
        contents = contents + "直陈式-简单将来时： \n"
           + "-----------------------\n"
           + strs[IndiFuturSim]
           + "=======================\n";
    }
    if (options[IndiFuterAnt])
    {
        contents = contents + "直陈式-先将来时： \n"
           + "-----------------------\n"
           + strs[IndiFuterAnt]
           + "=======================\n";
    }
    if (options[SubPresent])
    {
        contents = contents + "虚拟-现在时：\n"
           + "-----------------------\n"
           + strs[SubPresent]
           + "=======================\n";
    }
    if (options[SubPasse])
    {
        contents = contents + "虚拟-过去时： \n"
           + "-----------------------\n"
           + strs[SubPasse]
           + "=======================\n";
    }
    if (options[SubImpar])
    {
        contents = contents + "虚拟-未完成过去时： \n"
           + "-----------------------\n"
           + strs[SubImpar]
           + "=======================\n";
    }
    if (options[SubPlus])
    {
        contents = contents + "虚拟-愈过去时： \n"
           + "-----------------------\n"
           + strs[SubPlus]
           + "=======================\n";
    }
    if (options[ConPresent])
    {
        contents = contents + "条件式-现在时： \n"
           + "-----------------------\n"
           + strs[ConPresent]
           + "=======================\n";
    }
    if (options[ConPasse])
    {
        contents = contents + "条件式-过去时： \n"
           + "-----------------------\n"
           + strs[ConPasse]
           + "=======================\n";
    }
    if (options[ImpePresent])
    {
        contents = contents + "命令式-现在时： \n"
           + "-----------------------\n"
           + strs[ImpePresent]
           + "=======================\n";
    }
    if (options[ImpePasse])
    {
        contents = contents + "命令式-过去时： \n"
           + "-----------------------\n"
           + strs[ImpePasse]
           + "=======================\n";
    }
    // contents = contents + "直陈式\n";
    // contents = contents + "-------------------------\n";
    // contents = contents + "现在时： \n"
    //    + strs[IndiPresent];
    // contents = contents + "复合过去时： \n"
    //    + strs[IndiPasseCom];
    // contents = contents + "未完成过去时： \n"
    //    + strs[IndiImpar];
    // contents = contents + "愈过去时： \n"
    //    + strs[IndiPlus];
    // contents = contents + "简单过去时： \n"
    //    + strs[IndiPasseSim];
    // contents = contents + "先过去时： \n"
    //    + strs[IndiPasseAnt];
    // contents = contents + "简单将来时： \n"
    //    + strs[IndiFuturSim];
    // contents = contents + "先将来时： \n"
    //    + strs[IndiFuterAnt];
    // contents = contents + "=========================\n";
    // contents = contents + "虚拟\n";
    // contents = contents + "-------------------------\n";
    // contents = contents + "现在时： \n"
    //    + strs[SubPresent];
    // contents = contents + "过去时： \n"
    //    + strs[SubPasse];
    // contents = contents + "未完成过去时： \n"
    //    + strs[SubImpar];
    // contents = contents + "愈过去时： \n"
    //    + strs[SubPlus];
    // contents = contents + "=========================\n";
    // contents = contents + "条件式\n";
    // contents = contents + "-------------------------\n";
    // contents = contents + "现在时： \n"
    //    + strs[ConPresent];
    // contents = contents + "过去时： \n"
    //    + strs[ConPasse];
    // contents = contents + "=========================\n";
    // contents = contents + "命令式\n";
    // contents = contents + "-------------------------\n";
    // contents = contents + "现在时： \n"
    //    + strs[ImpePresent];
    // contents = contents + "过去时： \n"
    //    + strs[ImpePasse];
    // contents = contents + "=========================\n";
}
