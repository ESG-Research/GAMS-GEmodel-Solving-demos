
set ac     /sec1,sec2,sec3,com1,com2,com3,lab,cap,hh,ent,gov,vat,tariff,invsav,row,total/;
set a(ac)  /sec1,sec2,sec3/;
set c(ac)  /com1,com2,com3/;
set f(ac)  /lab,cap/;
set acnt(ac) ;
acnt(ac)=YES;
acnt('total')=NO;

alias (ac,acp),(a,ap),(c,cp),(f,fp),(acnt,acntp);


* The value of entrys in the SAM matrix can be modified to your data frame.

table sam(ac,acp)
           sec1      sec2      sec3      com1    com2        com3    lab     cap
sec1                                     110124                                        
sec2                                             1355353                      
sec3                                                         792258                                                            
com1       14684     64692     5691                                                                      
com2       21813     763245    128259                                                                    
com3       8175      194711    233249                                                                                 
lab        65271     139223    218774                                                                         
cap        3592      129146    172231                                                                           
hh                                                                   423268  30628                                                   
ent                                                                          277890                                                                           
gov                                                                                                           
vat        -3411     64336     34054                                                                                                 
tariff                                   277     2299        423                                                                   
invsav                                                                                                            
row                                      5740    118726      21802           -3549                                                             
total      110124    1355353   792258    116141  1476378     814483  423268  304969                                                                            

     +    hh      ent     gov      vat               tariff        invsav      row      total
sec1                                                                                    110124                                                                                  
sec2                                                                                    1355353                                
sec3                                                                                    762683                                        
com1      26241           1238                                     2401        1194     116141                         
com2      123835          0                                        306198      133028   1476378                            
com3      170350          122512                                   55861       29625    814483                              
lab                                                                                     423268     
cap                                                                                     304969      
hh                33437   24611                                                1012     512956                                                           
ent                                                                                     277890                                                    
gov       11966   32117            94979             2999                      34644    176705                     
vat                                                                                     94979     
tariff                                                                                  2999                          
invsav    180564  212336  27943                                                -56383   364460                              
row                       401                                                           143120                             
total     512956  277890  176705   94979             2999          364460      143120                                                       
;



*Check that the SAM matrix we input is consistent.
parameters

samchk(ac);
samCHK(acnt)=sum(acntp,SAM(acntp,acnt))-sum(acntp,SAM(acnt,acntp));

display samchk;

*Elastic parameters derived from estimates.
parameter  rhoAa(a)   /sec1 =   0.5,   sec2 = 0.6, sec3 = 0.6/
           rhoVA(a)   /sec1     0.3,   sec2   0.5, sec3   0.5/
           rhoQq(c)   /com1     2.0,   com2   2.0, com3   2.0/
           rhoCET(c)  /com1     3.6,   com2   2.5, com3   1.0/
           
*Definition of parameters
parameters
sax(a,c) 
scaleAa(a)       'The parameters of the CES function of QA'
deltaAa(a)       'The parameters of the CES function share of QA'
scaleQq(c)       'Parameters of QQ's Arminton function'
deltaQq(c)       'The parameters of QQ's Arminton function share'
scaleCET(c)      'The parameters of the CET function'
deltaCET(c)      'The parameters of the CET function share'
scaleAVA(a)      'Parameters of the CES function of VA'
deltaVA(a)       'The parameters of the labor share of the CES function of VA'
ica(c,a)         'Input-output coefficient of intermediate inputs'
shrh(c)          'Consumption expenditure share of household income to commodity c'
shrg(c)          'The share of consumer spending on good c in government revenue'
tih              'Income tax rates for residents'
tiEnt            'Corporate income tax rate'
tval(a)          'VAT rates on Labour and capital inputs'
transfrhg0       'Government transfer income to residents'
transfrhent0     'Company transfer income residents'
transfrhrow0     'Foreign transfer income residents'
transfrgRow0     'Foreign transfer income to Government'
transfrRowG0     'Foreign transfer income to resident'
shifhk           资本收入分配给居民的份额
shifentk         资本收入分配给企业的份额
mpc              居民h的边际消费倾向
tm(c)            进口税率
te(c)            出口税率
PA0(a)           生产活动a的价格
QA0(a)           生产活动a的数量
PVA0(a)          增值部分汇总价格
QVA0(a)          增值部分汇总量
PINTA0(a)        中间投入总价格
QINTA0(a)        中间投入总量
QINT0(c,a)       中间投入个量
QLD0(a)          劳动需求
QKD0(a)          资本需求
WL0              劳动价格
WK0              资本价格
PX0(c)           生产活动产出的QX商品c的价格
QX0(c)           生产活动产出的QX商品的数量
PQ0(c)           国内市场商品c的价格
QQ0(c)           国内市场商品c的数量
PM0(c)           进口商品c的价格
QM0(c)           进口商品c的数量
PE0(c)           国内生产商品c出口的价格
QE0(c)           国内生产商品c出口的数量
PD0(c)           国内生产国内使用商品c的价格
QD0(c)           国内生产国内使用商品c的数量
EXR0             汇率
pwm(c)           进口商品c的国际价格
pwe(c)           出口生产活动c商品的国际价格
QLSAGG0          劳动量总供应
QKSAGG0          资本量总供应
YH0              居民收入
EH0              居民消费总额
QH0(c)           居民对商品c的需求
YENT0            企业收入
EINV0            投资总额
QINV0(c)         对商品c的投资的最终需求
ENTSAV0          企业储蓄
YG0              政府收入
EG0              政府支出
QG0(c)           政府对商品c的需求
GSAV0            政府储蓄
PGDP0            国民生产总值价格指数
GDP0             实际国民生产总值
FSAV0            国外储蓄
EG0chk           用来检查和EGO是否一致
vadded0          总增值，用它和支出法两个方法来检查是否一致
GDP0chk          增值法和支出法两个方法是否一致
FINV0            国外资本的投资收益

;


*参数赋值与校调

PX0(c)=1;
QX0(c)=sum(a,sam(a,c))/PX0(c);
sax(a,c)=sam(a,c)/QX0(c);
PA0(a)=1;
PVA0(a)=1;
PD0(c)=1;
PE0(c)=1;
PM0(c)=1;

EXR0=1;
PINTA0(a)=1;
WK0=1;
WL0=1;

tval(a)=sam('vat',a)/(sam('lab',a)+sam('cap',a));
QLD0(a)=sam('lab',a)/WL0;
QKD0(a)=sam('cap',a)/WK0;

QVA0(a)=(SUM(f,sam(f,a))+sam('vat',a))/PVA0(a);
QA0(a)=sam('total',a)/PA0(a);
QLSAGG0=sam('total','lab')/WL0;
QKSAGG0=sam('total','cap')/WK0;

*国外部分
tm(c)$sam('row',c)=sam('tariff',c)/sam('row',c);
pwm(c)$sam('row',c)=PM0(c)/((1+tm(c))*EXR0);
QM0(c)=(sam('row',c)+sam('tariff',c))/PM0(c);
pwe(c)=PE0(c)/EXR0;
te(c)=0;
QE0(c)=sam(c,'row')/PE0(c);

QD0(c)=QX0(c)-QE0(c);
QQ0(c)=QD0(c)+QM0(c);
PQ0(c)=(sam(c,'total')-sam(c,'row'))/QQ0(c);

*生产模块的参数
QINT0(c,a)=sam(c,a)/PQ0(c);
QINTA0(a)=SUM(c,QINT0(c,a));
ica(c,a)=QINT0(c,a)/QINTA0(a);

deltaAa(a)=PVA0(a)*QVA0(a)**(1-rhoAa(a))/(PVA0(a)*QVA0(a)**(1-rhoAa(a))+PINTA0(a)*QINTA0(a)**(1-rhoAa(a)));
scaleAa(a)=QA0(a)/(deltaAa(a)*QVA0(a)**rhoAa(a)+(1-deltaAa(a))*QINTA0(a)**rhoAa(a))**(1/rhoAa(a));
deltaVA(a)=((1+tval(a))*WL0)*QLD0(a)**(1-rhoVA(a))/(((1+tval(a))*WL0)*QLD0(a)**(1-rhoVA(a))+((1+tval(a))*WK0)*QKD0(a)**(1-rhoVA(a)));
scaleAVA(a)=QVA0(a)/(deltaVA(a)*QLD0(a)**rhoVA(a)+(1-deltaVA(a))*QKD0(a)**rhoVA(a))**(1/rhoVA(a));

*CET内销和出口之间的选择
deltaCET(c)=PD0(c)*QD0(c)**(1-rhoCET(c))/(PD0(c)*QD0(c)**(1-rhoCET(c))+PE0(c)*QE0(c)**(1-rhoCET(c)));
scaleCET(c)=QX0(c)/(deltaCET(c)*QD0(c)**rhoCET(c)+(1-deltaCET(c))*QE0(c)**rhoCET(c))**(1/rhoCET(c));


*Armington Condition 在国内生产和进口之间的选择
deltaQq(c)=PD0(c)*QD0(c)**(1-rhoQQ(c))/(PD0(c)*QD0(c)**(1-rhoQq(c))+PM0(c)*QM0(c)**(1-rhoQq(c)));
scaleQQ(c)=QQ0(c)/(deltaQq(c)*QD0(c)**rhoQq(c)+(1-deltaQq(c))*QM0(c)**rhoQq(c))**(1/rhoQq(c));

*其他参数和外生变量的校调和估算
transfrhg0=sam('hh','gov');
transfrhent0=sam('hh','ent');
transfrhrow0=sam('hh','row');
*transfrEntG0=sam('ent','gov');
transfrRowG0=sam('row','gov');
transfrgRow0=sam('gov','row');
*shifhl(h)=(sam(h,'lab')/WL0)/QLSAGG0;
shifhk=(sam('hh','cap')/WK0)/QKSAGG0;
shifentk=(sam('ent','cap')/WK0)/QKSAGG0;
YH0=WL0*QLSAGG0+shifhk*WK0*QKSAGG0+transfrhg0+transfrhent0+transfrhrow0*EXR0;
tih=sam('gov','hh')/YH0;
mpc=sum(c,sam(c,'hh'))/((1-tih)*YH0);
EH0=mpc*(1-tih)*YH0;
QH0(c)=SAM(c,'hh')/PQ0(c);
shrh(c)=(PQ0(c)*QH0(c))/EH0;
YENT0=shifentk*WK0*QKSAGG0;
QINV0(c)=sam(c,'invsav')/PQ0(c);
EINV0=sum(c,PQ0(c)*QINV0(c));
tiEnt=sam('gov','ent')/YEnt0;
ENTSAV0=(1-tiEnt)*YENT0-transfrhent0 ;
YG0=tih*YH0+tiEnt*YENT0+sum(a,tval(a)*WL0*QLD0(a)+tval(a)*WK0*QKD0(a))+sam('gov','tariff')+sam('gov','row');
QG0(c)=sam(c,'gov')/PQ0(c);
GSAV0=sam('invsav','gov');
EG0=YG0-GSAV0;
shrg(c)=PQ0(c)*QG0(c)/(EG0-transfrhg0-transfrRowG0*EXR0);

GDP0=sum(c,QH0(c)+QINV0(c)+QG0(c)+QE0(c)-QM0(c));
PGDP0=(sum(c,PQ0(c)*(QH0(c)+QINV0(c)+QG0(c))+PE0(c)*QE0(c)-PM0(c)*QM0(c)+tm(c)*pwm(c)*QM0(c)*EXR0))/GDP0;
     
FSAV0=sam('invsav','row');

EG0chk=sum(c,sam(c,'gov'))+transfrhg0+transfrRowG0-EG0;
vadded0=sum(a,(1+tval(a))*WL0*QLD0(a)+(1+tval(a))*WK0*QKD0(a))+sum(c,tm(c)*pwm(c)*QM0(c)*EXR0);
GDP0chk=vadded0-PGDP0*GDP0;

FINV0=sam('row','cap');

display ica,PQ0,EG0,EG0chk,PGDP0,GDP0,vadded0,GDP0chk,shrg,shifhk,shifentk,mpc,tih,transfrhrow0,transfrhent0,transfrhg0,tval,tiEnt,tm,transfrgrow0,transfrRowG0,sax,pwe;


variable
*38个
PA(a),PVA(a),PINTA(a),WL,WK,QA(a),QVA(a),QINTA(a),QINT(c,a),QLD(a),
QKD(a),QX(c),QD(c),QE(c),PX(c),PD(c),PE(c),PQ(c),QQ(c),PM(c),
QM(c),YH,QH(c),QINV(c),QG(c),YENT,ENTSAV,EINV,YG,
EG,GSAV,QLSAGG,QKSAGG,FSAV,GDP,PGDP,EXR,walras,FINV;



*定义等式
equation
*33个
QAfn(a),QAFOCeq(a),PAeq(a),QVAfn(a),QVAFOC(a),PVAeq(a),QINTfn(c,a),PINTAeq(a),CETfn(c),CETFOC(c),
PXCET(c),PEeq(c),QQfn(c),QQFOC(c),PQeq(c),PMeq(c),YHeq,QHeq(c),YENTeq,ENTSAVeq,
EINVeq,Ygeq,QGeq(c),GSAVeq,ComEqui(c),Leq,Keq,FEXeq,ISeq,GDPeq,
PGDPeq,QAQXeq(a),PXeq(c),KKeq
;

*生产模块

QAfn(a)..
QA(a)=e=scaleAa(a)*(deltaAa(a)*QVA(a)**rhoAa(a)+(1-deltaAa(a))*QINTA(a)**rhoAa(a))**(1/rhoAa(a));

QAFOCeq(a)..
PVA(a)/PINTA(a)=e=(deltaAa(a)/(1-deltaAa(a)))*(QINTA(a)/QVA(a))**(1-rhoAa(a));

PAeq(a)..
PA(a)*QA(a)=e=PVA(a)*QVA(a)+PINTA(a)*QINTA(a);

QVAfn(a)..
QVA(a)=e=scaleAVA(a)*(deltaVA(a)*QLD(a)**rhoVA(a)+(1-deltaVA(a))*QKD(a)**rhoVA(a))**(1/rhoVA(a));

QVAFOC(a)..
((1+tval(a))*WL)/((1+tval(a))*WK)=e=(deltaVA(a)/(1-deltaVA(a)))*(QKD(a)/QLD(a))**(1-rhoVA(a));

PVAeq(a)..
PVA(a)*QVA(a)=e=(1+tval(a))*WL*QLD(a)+(1+tval(a))*WK*QKD(a);

QINTfn(c,a)..
QINT(c,a)=e=ica(c,a)*QINTA(a);

PINTAeq(a)..
PINTA(a)=e=SUM(c,ica(c,a)*PQ(c));


***QX=QA
QAQXeq(a)..
QA(a)=e=sum(c,sax(a,c)*QX(c));

PXeq(c)..
*PX(c)*QX(c)=e=sum(a,PA(a)*sax(a,c)*QA(a));
PX(c)=e=sum(a,PA(a)*sax(a,c));


*国际部分
CETfn(c)..
QX(c)=e=scaleCET(c)*(deltaCET(c)*QD(c)**rhoCET(c)+(1-deltaCET(c))*QE(c)**rhoCET(c))**(1/rhoCET(c));

CETFOC(c)..
PD(c)/PE(c)=e=(deltaCET(c)/(1-deltaCET(c)))*(QE(c)/QD(c))**(1-rhoCET(c));

PXCET(c)..
PX(c)*QX(c)=e=(PD(c)*QD(c)+PE(c)*QE(c));

PEeq(c)..
PE(c)=e=pwe(c)*(1-te(c))*EXR;

QQfn(c)$sam('row',c)..
QQ(c)=e=scaleQq(c)*(deltaQq(c)*QD(c)**rhoQq(c)+(1-deltaQq(c))*QM(c)**rhoQq(c))**(1/rhoQq(c));

QQFOC(c)$sam('row',c)..
PD(c)/PM(c)=e=(deltaQq(c)/(1-deltaQq(c)))*(QM(c)/QD(c))**(1-rhoQq(c));

PQeq(c)..
PQ(c)*QQ(c)=e=PD(c)*QD(c)+PM(c)*QM(c);

PMeq(c)..
PM(c)=e=pwm(c)*(1+tm(c))*EXR;

*居民

YHeq..
YH=e=WL*QLSAGG+shifhk*WK*QKSAGG+transfrhent0+transfrhg0+transfrhrow0*EXR;

QHeq(c)..
PQ(c)*QH(c)=e=shrh(c)*mpc*(1-tih)*YH;

*企业
YENTeq..
YENT=e=shifentk*WK*QKSAGG;

ENTSAVeq..
ENTSAV=e=(1-tiEnt)*YENT-transfrhEnt0;

EINVeq..
EINV=e=sum(c,PQ(c)*QINV(c));

*政府
YGeq..
YG=e=sum(a,tval(a)*(WL*QLD(a)+WK*QKD(a)))+tih*YH+tiEnt*YENT+sum(c,tm(c)*pwm(c)*QM(c)*EXR)+transfrgrow0*EXR;

QGeq(c)..
PQ(c)*QG(c)=e=shrg(c)*(EG-transfrhg0-transfrRowG0);

GSAVeq..
GSAV=e=YG-EG;

ComEqui(c)..
QQ(c)=e=sum(a,QINT(c,a))+QH(c)+QINV(c)+QG(c);

*要素市场
Leq..
Sum(a,QLD(a))=e=QLSAGG;

Keq..
Sum(a,QKD(a))=e=QKSAGG;

KKeq..
YENT+shifhk*WK*QKSAGG+FINV=e=QKSAGG;

*国际市场
FEXeq..
sum(c,pwm(c)*QM(c))+transfrRowG0+FINV=e=sum(c,pwe(c)*QE(c))+transfrgrow0+FSAV+transfrhrow0;

*储蓄等于投资
ISeq..
EINV=e=(1-mpc)*(1-tih)*YH+ENTSAV+GSAV+FSAV*EXR+walras;

GDPeq..
GDP=e=sum(c,QH(c)+QINV(c)+QG(c)+QE(c)-QM(c));

PGDPeq..
PGDP*GDP=e=sum(c,PQ(c)*(QH(c)+QINV(c)+QG(c)))+sum(c,PE(c)*QE(c))-sum(c,PM(c)*QM(c))+sum(c,tm(c)*pwm(c)*QM(c)*EXR);

 
*赋予变量的初始值

PA.l(a)=PA0(a);
PVA.l(a)=PVA0(a);
PINTA.l(a)=PINTA0(a);
QA.l(a)=QA0(a);
QVA.l(a)=QVA0(a);
QINTA.l(a)=QINTA0(a);
QINT.l(c,a)=QINT0(c,a);
QLD.l(a)=QLD0(a);
QKD.l(a)=QKD0(a);
PX.l(c)=1;
QX.l(c)=QX0(c);
PD.l(c)=1;
QD.l(c)=QD0(c);
PE.l(c)=1;
QE.l(c)=QE0(c);
PQ.l(c)=1;
QQ.l(c)=QQ0(c);
PM.l(c)=1;
QM.l(c)=QM0(c);
YH.l=YH0;
QH.l(c)=QH0(c);
YENT.l=YENT0;
ENTSAV.l=ENTSAV0;
EINV.l=EINV0;
YG.l=YG0;
GSAV.l=GSAV0;
FSAV.l=FSAV0;
GDP.l=GDP0;
PGDP.l=PGDP0;
walras.l=0;
QLSAGG.l=QLSAGG0;
QKSAGG.l=QKSAGG0;
FINV.l = FINV0;

*凯恩斯闭合，也可随意换，怎么换参考张欣的书
WL.fx=1;
WK.fx=1;
QINV.fx(c)=QINV0(c);

FSAV.fx=FSAV0;
EXR.fx = EXR0;

*执行优化程序
model cge  /all/;
solve cge using mcp;

*模拟税收冲击，需要根据自己的冲击来修改
tval(a)=0.01;

model sim1  /all/;
solve sim1 using mcp;
