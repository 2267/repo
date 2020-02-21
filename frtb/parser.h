#ifndef __FB_PARSER_H__
#define __FB_PARSER_H__

#include <string>
#include <sstream>
#include <vector>
#include <regex>

enum SOURCE{
    Frdic
};

enum TYPE{
    CONJ,
    MEAN
};

enum CONJ{
    ParPresent,  //现在分词
    ParPasse,   //过去分词
    IndiPresent,  //直陈式 现在时
    IndiPasseCom, //直陈式 复合过去时
    IndiImpar,  //直陈式 未完成过去时
    IndiPlus,  //直陈式 愈过去时
    IndiPasseSim, //直陈式 简单过去时
    IndiPasseAnt, //直陈式 先过去时
    IndiFuturSim,  //直陈式 简单将来时
    IndiFuterAnt, //直陈式 先将来时
    SubPresent,  //虚拟 现在时
    SubPasse,  //虚拟 过去时
    SubImpar,  //虚拟 未完成过去时
    SubPlus,  //虚拟 愈过去时
    ConPresent,  //条件式 现在时
    ConPasse,  //条件式 过去时
    ImpePresent,  //命令式 现在时
    ImpePasse,  //命令式 过去时
    _SIZE
};

std::vector<std::string> parse(std::string s , TYPE type= CONJ, SOURCE src = Frdic);
std::vector<std::string> parse_frdic(std::string s, TYPE type= CONJ);


#endif