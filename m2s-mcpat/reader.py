class reader:
    mem = dict()
    x86 = dict()
    res = dict()
    def __init__(self, x86, mem):
        self.parse_mem(mem)
        self.parse_x86(x86)
        self.calc()
        self.config()
        self.proc()
    def calc(self):
        num_cache = 0
        num_l2 = 0
        num_l3 = 0
        num_core = 0
        num_thread = 0
        num_net = 0
        num_level = 1
        for i in self.mem.keys():
            if i[0:5]=='cache':
                num_cache = num_cache + 1
                if 'l2' in i:
                    num_l2 = num_l2 + 1
                if 'l3' in i:
                    num_l3 = num_l3 + 1
            if i[0:7]=='Network' :
                num_net = num_net + 1
        self.res.update({'num_l2':num_l2,'num_l3':num_l3,'num_cache':num_cache,'num_net':num_net})
        if num_l3:
            num_level = 3
        elif num_l2:
            num_level = 2
        else:
            num_level = 1
        self.res.update({'num_level':num_level})
        for i in self.x86.keys():
        # you should change here if you need heterogenerous cores
            if len(i) >= 4:
                if i[0]=='c' and i[2]=='t':
                    if i[1]=='0':
                        num_thread = num_thread +1
                    if i[3]=='0':
                        num_core = num_core + 1
        self.res.update({'num_core':num_core,'num_thread':num_thread})

        self.res.update({'cycle': self.x86['Global']['Cycles']})
        self.res.update({'pipeline_duty_cycle':self.x86['c0']['Commit.DutyCycle']})
        n = 0
        if num_level == 1:
            n = self.mem['Network.net-l1-mm.General']['Transfers']
            n = int(n)
        elif num_level == 2:
            n1 = self.mem['Network.net-l1-l2.General']['Transfers']
            n2 = self.mem['Network.net-l2-mm.General']['Transfers']
            n = int(n1) + int(n2)
        else:
            n1 = self.mem['Network.net-l1-l2.General']['Transfers']
            n2 = self.mem['Network.net-l2-l3.General']['Transfers']
            n3 = self.mem['Network.net-l3-mm.General']['Transfers']
            n = int(n1) + int(n2) + int(n3)
        self.res.update({'net_access':str(n)})
    def config(self):
        num = self.res['num_level'] + 1
        for c in ['i','d','l2','l3']:
            if not num:
                break
            else:
                num=num-1
                set = self.mem['cache-'+c+'0']['Sets']
                way = self.mem['cache-'+c+'0']['Assoc']
                block_size =  self.mem['cache-'+c+'0']['BlockSize']
                latency = self.mem['cache-'+c+'0']['Latency']
                size = str(int(set)*int(way)*int(block_size))
                config = size+','+block_size+','+way+',1,8,'+latency+','+'64,1'
                self.res.update({c+'_config':config})
                port = self.mem['cache-'+c+'0']['Ports']
                self.res.update({c+'_port':port+','+port+','+port})
        
    def proc(self):
        with open('map') as f:
            while True:
                line = f.readline()
                value = ''
                if not line:
                    break
                (target, type, origin)= line.strip().split(',')
                if type == 'c':
                    num = 0
                    for i in range(0, int(self.res['num_core'])):
                        num = num + int(self.x86['c' + str(i)][origin])
                    value = str(num)
                elif type == 't':
                    num = 0
                    for i in range(0, int(self.res['num_core'])):
                        for j in range(0, int(self.res['num_thread'])):
                            num = num + int(self.x86['c' + str(i) + 't' + str(j)][origin])
                    value = str(num)
                elif type == 'i' or type == 'd':
                    num = 0
                    for i in range(0, int(self.res['num_core'])):
                        num = num + int(self.mem['cache-'+ type + str(i)][origin])
                    value = str(num)
                elif type == '2':
                    num = 0
                    for i in range(0, int(self.res['num_l2'])):
                        num = num + int(self.mem['cache-l2' + str(i)][origin])
                    value = str(num)
                elif type == '3':
                    num = 0
                    for i in range(0, int(self.res['num_l3'])):
                        num = num + int(self.mem['cache-l3' + str(i)][origin])
                    value = str(num)
                elif type == 'm':
                    value = self.mem['mem'][origin]
                self.res.update({target:value})
        f.close()


    def get(self, name):
        return str(self.res[name])
        
    def parse_mem(self, file):
        mod = ''
        content = dict()
        all = dict()
        with open(file) as f1:
            while True:
                line = f1.readline()
                if not line:
                    #self.mem = self.mem + '['
                    break
                else:
                    line = line.strip()
                    if not line:
                        all.update({mod:content})
                        continue
                    elif line[0] == '[':
                        all.update({mod:content})
                        mod = line[1:-1].strip()
                        content = dict()
                    elif line[0]!=';':
                        key = line.split("=")[0].strip()
                        val = line.split("=")[1].strip()
                        content.update({key:val})
        f1.close()
        self.mem = all
    
    def parse_x86(self, file):
        mod = ''
        content = dict()
        all = dict()
        with open(file) as f1:
            while True:
                line = f1.readline()
                if not line:
                    #self.mem = self.mem + '['
                    break
                else:
                    line = line.strip()
                    if not line:
                        all.update({mod:content})
                        continue
                    elif line[0] == '[':
                        all.update({mod:content})
                        mod = line[1:-1].strip()
                        content = dict()
                    elif line[0]!=';':
                        key = line.split("=")[0].strip()
                        val = line.split("=")[1].strip()
                        content.update({key:val})
        f1.close()
        self.x86 = all
