
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
shifhk           'The share of capital income distributed to residents'
shifentk         'The share of capital income allocated to the enterprise'
mpc              'The share of capital income allocated to the enterprise'
tm(c)            'Tax rate import'
te(c)            'Tax rate outport'
PA0(a)           'The price of production activity-a'
QA0(a)           'The quantity of production activity-a'
PVA0(a)          'Value added part of the summary price'
QVA0(a)          'Total value added'
PINTA0(a)        'Total price of intermediate inputs'
QINTA0(a)        'Total quantity of intermediate input'
QINT0(c,a)       'Individual quantity of intermediate input'
QLD0(a)          'Quantity of labour demand'
QKD0(a)          'Quantity of Kapital demand'
WL0              'price of labor'
WK0              'price of kapital'
PX0(c)           'The price of the QX commodity c produced by the production activity'
QX0(c)           'The quantity of the QX commodity c produced by the production activity'
PQ0(c)           'The price of the Q commodity c produced by the production activity'
QQ0(c)           'The quantity of the Q commodity c produced by the production activity'
PM0(c)           'The price of imported commodity c'
QM0(c)           'The quantity of imported commodity c'
PE0(c)           'The export price of the domestically produced commodity c'
QE0(c)           'The export quantity of the domestically produced commodity c'
PD0(c)           'Domestic production The price of commodity c for domestic use'
QD0(c)           'Domestic production The quantity of commodity c for domestic use'
EXR0             'exchange rate'
pwm(c)           'The international price of imported commodity c'
pwe(c)           'The international price of commodity c for export production activities'
QLSAGG0          'Total supply of labor'
QKSAGG0          'Total supply of capital quantity'
YH0              'Household income'
EH0              'Total household consumption'
QH0(c)           'Household' demand for commodity c'
YENT0            'Enterprise revenue'
EINV0            'Total Investment'
QINV0(c)         'Final demand for investment in commodity c'
ENTSAV0          'Enterprise savings'
YG0              'Government revenue'
EG0              'Government expenditures'
QG0(c)           'Government demand for commodity c'
GSAV0            'Government saving'
PGDP0            'Gross domestic product price index'
GDP0             'Real Gross national product'
FSAV0            'Foreign savings'
EG0chk           'Used to check for consistency with EGO'
vadded0          'Total value added, use it and the expenditure method to check whether the consistent hold'
GDP0chk          'Whether the value-added method and the expenditure method are consistent'
FINV0            'Investment income of foreign kapital'

;


*Parameter assignment and calibration

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

*Foreign module
tm(c)$sam('row',c)=sam('tariff',c)/sam('row',c);
pwm(c)$sam('row',c)=PM0(c)/((1+tm(c))*EXR0);
QM0(c)=(sam('row',c)+sam('tariff',c))/PM0(c);
pwe(c)=PE0(c)/EXR0;
te(c)=0;
QE0(c)=sam(c,'row')/PE0(c);

QD0(c)=QX0(c)-QE0(c);
QQ0(c)=QD0(c)+QM0(c);
PQ0(c)=(sam(c,'total')-sam(c,'row'))/QQ0(c);

*Production module parameters
QINT0(c,a)=sam(c,a)/PQ0(c);
QINTA0(a)=SUM(c,QINT0(c,a));
ica(c,a)=QINT0(c,a)/QINTA0(a);

deltaAa(a)=PVA0(a)*QVA0(a)**(1-rhoAa(a))/(PVA0(a)*QVA0(a)**(1-rhoAa(a))+PINTA0(a)*QINTA0(a)**(1-rhoAa(a)));
scaleAa(a)=QA0(a)/(deltaAa(a)*QVA0(a)**rhoAa(a)+(1-deltaAa(a))*QINTA0(a)**rhoAa(a))**(1/rhoAa(a));
deltaVA(a)=((1+tval(a))*WL0)*QLD0(a)**(1-rhoVA(a))/(((1+tval(a))*WL0)*QLD0(a)**(1-rhoVA(a))+((1+tval(a))*WK0)*QKD0(a)**(1-rhoVA(a)));
scaleAVA(a)=QVA0(a)/(deltaVA(a)*QLD0(a)**rhoVA(a)+(1-deltaVA(a))*QKD0(a)**rhoVA(a))**(1/rhoVA(a));

*CET accounting between domestic sales and exports
deltaCET(c)=PD0(c)*QD0(c)**(1-rhoCET(c))/(PD0(c)*QD0(c)**(1-rhoCET(c))+PE0(c)*QE0(c)**(1-rhoCET(c)));
scaleCET(c)=QX0(c)/(deltaCET(c)*QD0(c)**rhoCET(c)+(1-deltaCET(c))*QE0(c)**rhoCET(c))**(1/rhoCET(c));


*Armington Condition CES Constant Elastic Substitution
deltaQq(c)=PD0(c)*QD0(c)**(1-rhoQQ(c))/(PD0(c)*QD0(c)**(1-rhoQq(c))+PM0(c)*QM0(c)**(1-rhoQq(c)));
scaleQQ(c)=QQ0(c)/(deltaQq(c)*QD0(c)**rhoQq(c)+(1-deltaQq(c))*QM0(c)**rhoQq(c))**(1/rhoQq(c));

*Calibration and estimation of other parameters and exogenous variables
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



*Defining equality
equation
*Totally 33 equitions
QAfn(a),QAFOCeq(a),PAeq(a),QVAfn(a),QVAFOC(a),PVAeq(a),QINTfn(c,a),PINTAeq(a),CETfn(c),CETFOC(c),
PXCET(c),PEeq(c),QQfn(c),QQFOC(c),PQeq(c),PMeq(c),YHeq,QHeq(c),YENTeq,ENTSAVeq,
EINVeq,Ygeq,QGeq(c),GSAVeq,ComEqui(c),Leq,Keq,FEXeq,ISeq,GDPeq,
PGDPeq,QAQXeq(a),PXeq(c),KKeq
;

*Production module

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


*International part
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

*Households

YHeq..
YH=e=WL*QLSAGG+shifhk*WK*QKSAGG+transfrhent0+transfrhg0+transfrhrow0*EXR;

QHeq(c)..
PQ(c)*QH(c)=e=shrh(c)*mpc*(1-tih)*YH;

*Enterprises
YENTeq..
YENT=e=shifentk*WK*QKSAGG;

ENTSAVeq..
ENTSAV=e=(1-tiEnt)*YENT-transfrhEnt0;

EINVeq..
EINV=e=sum(c,PQ(c)*QINV(c));

*Government
YGeq..
YG=e=sum(a,tval(a)*(WL*QLD(a)+WK*QKD(a)))+tih*YH+tiEnt*YENT+sum(c,tm(c)*pwm(c)*QM(c)*EXR)+transfrgrow0*EXR;

QGeq(c)..
PQ(c)*QG(c)=e=shrg(c)*(EG-transfrhg0-transfrRowG0);

GSAVeq..
GSAV=e=YG-EG;

ComEqui(c)..
QQ(c)=e=sum(a,QINT(c,a))+QH(c)+QINV(c)+QG(c);

*Input factors market
Leq..
Sum(a,QLD(a))=e=QLSAGG;

Keq..
Sum(a,QKD(a))=e=QKSAGG;

KKeq..
YENT+shifhk*WK*QKSAGG+FINV=e=QKSAGG;

*International market
FEXeq..
sum(c,pwm(c)*QM(c))+transfrRowG0+FINV=e=sum(c,pwe(c)*QE(c))+transfrgrow0+FSAV+transfrhrow0;

*Saving equal to investment
ISeq..
EINV=e=(1-mpc)*(1-tih)*YH+ENTSAV+GSAV+FSAV*EXR+walras;

GDPeq..
GDP=e=sum(c,QH(c)+QINV(c)+QG(c)+QE(c)-QM(c));

PGDPeq..
PGDP*GDP=e=sum(c,PQ(c)*(QH(c)+QINV(c)+QG(c)))+sum(c,PE(c)*QE(c))-sum(c,PM(c)*QM(c))+sum(c,tm(c)*pwm(c)*QM(c)*EXR);

 
*The initial value assigned to a variable

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

*Keynesian closure 
WL.fx=1;
WK.fx=1;
QINV.fx(c)=QINV0(c);

FSAV.fx=FSAV0;
EXR.fx = EXR0;

*Excute optimization operation
model cge  /all/;
solve cge using mcp;

*Simulated tax subsidy policy shock
tval(a)=0.01;

model sim1  /all/;
solve sim1 using mcp;
