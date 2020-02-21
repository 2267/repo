#ifndef __FB_NETWORK_H__
#define __FB_NETWORK_H__

#include <curl/curl.h>
#include <sstream>
#include <string>
#include <stdlib.h>


static size_t wb_func(void *recv, size_t size, size_t nmemb, std::stringstream *datap)
{
    *datap << (char*)recv;
    return size * nmemb;
}


std::string network_get(std::string url);
std::string network_post(std::string url);

#endif