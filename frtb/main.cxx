#include "query.h"
#include "printer.h"

using namespace std;

int main(int argc, char *argv[])
{
    char option[argc];
    string value[argc];

    if (argc == 1)
    {
        cout << "./frbt -h to see the usage\n";
        exit(0);
    }
    else if (argv[argc - 1][0] == '-' && argv[argc - 1][1] != 'h')
    {
        cerr << "wrong usage!\n";
        exit(0);
    }
    else
    {
        for (int i = 1; i < argc; i++)
        {
            if (argv[i][0] == '-')
            {
                option[i] = argv[i][1];
            }
            else
            {
                value[i] = argv[i];
            }
        }
    }

    for (char i : option)
    {
        if (i == 'h')
        {
            cout << "usage:\n";
            cout << "  -h        :\thelp information\n";
            cout << "  -c  [word]:\tquery conjugation\n";
            cout << "  -m  [word]:\tquery meaning (chinese)\n";
            cout << "  -o  [path]:\tredirect output to file, default: \"std\"\n";
            cout << "  -f  [flag]:\toptions for some functions\n"
                 << "      for -c:\n"
                 << "                 : indicatif Présent\n"
                 << "          ind    : indicatif\n"
                 << "          sub    : Subjonctif\n"
                 << "          con    : Conditionnel\n"
                 << "          imp    : Impératif\n"
                 << "          par    : Participe\n"
                 << "          all    : all\n";
            exit(0);
        }
    }
    string word = "";
    TYPE type = TYPE::CONJ;
    ofstream ofile;
    string flag = "";
    string file = "";
    bool change_output = false;
    for (int i = 0; i != argc; i++)
    {
        if (!option[i])
        {
            continue;
        }
        switch (option[i])
        {
        case 'c':
            word = value[i + 1];
            type = TYPE::CONJ;
            break;
        case 'o':
            if (value[i + 1] != "std")
            {
                file = value[i + 1];
                change_output = true;
            }
            break;
        case 'm':
            type = TYPE::MEAN;
            word = value[i + 1];
            break;
        case 'f':
            flag = value[i + 1];
        default:
            break;
        }
    }

    if (word == "")
    {
        cerr << "wrong usage!\n";
    }
    else
    {

        Query query(word, type);
        vector<string> re = query.get_result();
        fb_printer *fbp = new fb_printer();
        fbp->set_strs(re);
        fbp->set_options(flag);
        fbp->format(type);

        ofile.open(file);
        if (change_output)
            fbp->print(ofile);
        else
            fbp->print();
    }
}
