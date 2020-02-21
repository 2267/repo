class writer:
    tab=""
    file=""
    level=0
    def __init__(self, file):
        self.file = file
        with open(self.file, 'w') as f:
            f.write('<?xml version="1.0" ?>\n')
        f.close()
    def set_tab(self,num):
        self.tab=''
        for i in range(0, num):
            self.tab=self.tab+'\t'
    def com1(self, id, name):
        with open(self.file, 'a') as f:
            f.write(self.tab+'<component id="'+id+'" name="'+name+'">\n')
            #<component id="root" name="root">
        self.level = self.level+1
        self.set_tab(self.level)
        f.close()
    def param(self, name, value):
        with open(self.file, 'a') as f:
            f.write(self.tab+'<param name="'+name+'" value="'+value+'"/>\n')
        f.close() 
    def stat(self, name, value):
        with open(self.file, 'a') as f:
            f.write(self.tab+'<stat name="'+name+'" value="'+value+'"/>\n')
        f.close()  
    def com2(self):
        if self.level>0:
            self.level = self.level - 1
            self.set_tab(self.level)
        with open(self.file, 'a') as f:
            f.write(self.tab+'</component>\n')
            # <component id="root" name="root">
        f.close()    
'''
    def do(self, type, *args):
        with open(self.file, 'a') as f:
            if type=='com1':
                (id, name)=args
            elif type=='com2':
                f.write(self.tab+'<component/>\n')
            elif type == 'param' or type == 'stat':
                (name, value)=args
                f.write(self.tab+'<'+type+' name="'+name+'" value="'+value+'"/>\n')
            else:
                f.write(self.tab+'<!--'+args[0]+'-->\n')
        f.close()
'''