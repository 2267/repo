#ifndef __FB_QUERY_H__
#define __FB_QUERY_H__

#include "parser.h"
#include "network.h"



class Query{

    std::vector<std::string> result;
    std::string url;

public:
    Query(std::string word, TYPE type = CONJ, SOURCE site = Frdic);
    std::vector<std::string> get_result(){
        return result;
    }
};


#endif