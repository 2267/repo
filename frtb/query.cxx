#include "query.h"
using namespace std;

Query::Query(string word, TYPE type, SOURCE site)
{
    string raw;
    switch (type)
    {
    case CONJ:
        switch (site)
        {
        case Frdic:
            url = "http://www.frdic.com/dicts/cg/" + word;
            break;
        default:
            url = "http://www.frdic.com/dicts/cg/" + word;
            break;
        }
    break;
    case MEAN:
        switch(site){
        case Frdic:
            url = "http://www.frdic.com/dicts/fr/" + word;
        break;
        }
    break;
    }
    raw = network_get(url);
    result = parse(raw, type, site);
}