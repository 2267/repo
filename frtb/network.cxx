#include "network.h"
#include <iostream>
using namespace std;

string network_get(string url){
    CURL *curl = curl_easy_init();
    CURLcode *code;
    const char *ua = "Mozilla/5.0 (Windows NT 10.0; WOW64)  \
        AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.99 \
        YaBrowser/19.1.0.2644 Yowser/2.5 Safari/537.36";
    const char *url_c = url.c_str();
    stringstream *s = new stringstream();
    curl_easy_setopt(curl, CURLOPT_URL, url_c);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, s);
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, wb_func);
    curl_easy_perform(curl);
    curl_easy_cleanup(curl);

    string line;
    string result;
    while( *s>> line){
        result = result + " " + line ;
    }
    return result;
}