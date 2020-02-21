#ifndef __FB_PRINTER_H__
#define __FB_PRINTER_H__
#include "parser.h"
#include <iostream>
#include <fstream>
#include <string>
#include <vector>



class fb_printer{
    std::vector<std::string> strs;
    std::string contents;
    // std::vector<bool> options;
    // TYPE type = CONJ; 
    bool options[_SIZE];
    void format_conj();
public:
    fb_printer(){
        for(bool &x : options)
           x = false;
    }
    void print();
    void print(std::ostream &dest);
    void set_strs(std::vector<std::string> _strs){strs = _strs;}
    void format(TYPE _type = CONJ );
    void set_options(std::string);
};

#endif