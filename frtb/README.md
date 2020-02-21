# 法语工具箱 (French ToolBox)

The reason I create this tool is to help me learn French while working on linux and having space time. It's like a dictionary (I do collect the data from some websites), or a software that help you keep something hard to memory in mind.  
Maybe I should use language like python instead of c++ to take care of tasks like this. 



## installation

```bash
sudo apt install g++ make libcurl4-openssl-dev 
# if you are using ubuntu, debian
git clone git@github.com:0xNi/french-toolbox.git
make
./frtb -h # to show the usage
```

<!-- or you can use the `install.sh` to easy install to /usr/local/share-->


## bug
- The conjugation query will fail for part of words (that contains accent/letters other than english letters) because fail to parse data correctly from websites (lead to the Participe Passé page instead of the summary page in frdic.com).
- The meaning query results are shown incompletely because of string format.

## history version

### v0.15
- support to query (chinese) meaning of a word (fr -> ch)
- support redirect output

### v0.10
- only can query conjugations 
- only support Chinese output (to terminal)
- data are scratched from [frdic](https://www.frdic.com)
