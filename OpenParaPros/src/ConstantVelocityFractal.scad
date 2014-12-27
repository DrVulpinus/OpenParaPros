//This code generates a fractal pattern of tubes designed to maintain a constant velocity of airflow throughout the enitire network, including the inlets.  This should create an ideal flow of air throught the whole network.

//The values are calculated given an initial diameter, and a limiting minimum diameter for the tubes.

//Info for diameter, flowrate, and velocity calulations was obtained from here:
//http://www.1728.org/flowrate.htm


//This code is based off of FractalManafold.scad

initDia = 50; //The initial diameter for the tubes
finalDiaMin = 3;  //The minimum diameter for the tubes
myScale=.68;  //The scale factor for each length of tubing
myHeight=200; //The initial tubing length


function getDia(flow)=sqrt((4*flow)/3.1415); //Returns the diameter based on a fixed velocity value and a given flow rate

module link(length=20,scaleFactor=.9,minimumDia=3,branchingAngle=60,branchingOrder=2, flow = 100, dia = 50){
children(0);
outFlow = flow/(branchingOrder +1);
newDia = getDia(outFlow);
translate([0,0,length]){
cylinder(h = newDia/2, d1 = dia, d2 = 0);
}
for(i = [0:(branchingAngle)/(branchingOrder):branchingAngle]){
translate([0,0,length]){
rotate([i-branchingAngle/2,0,0]){
if(minimumDia<newDia){
link(length*scaleFactor,scaleFactor,minimumDia,branchingAngle,branchingOrder, flow = outFlow, dia = newDia){
cylinder(h=length * scaleFactor,d=newDia,center=false);
}
}
//At each end point
if(minimumDia>newDia){
translate([-dia/2,0,0]){
rotate([0,90,0])
cylinder(h=myHeight/5,d=dia,center=false);
}
}
}
}
}
}


initFlow=.25*3.1415*(pow(initDia,2));//Calculate the initial flow rate given a fixed velocity of 1 (dimensionless since this will only be used for calculating relative diameters) and the initial diameter


link(length=myHeight,scaleFactor=myScale,finalDiaMin=3,branchingAngle=180,branchingOrder=1, flow=initFlow, dia = initDia){
cylinder(h=myHeight,d=initDia,center=false);

}