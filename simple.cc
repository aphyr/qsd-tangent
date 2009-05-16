// Simple harmonic oscillator, one trajectory.

#include <math.h>
#include <stdio.h>
#include <iostream.h>
#include <fstream.h>

#include "ACG.h"
#include "Traject.h"
#include "State.h"
#include "Operator.h"
#include "FieldOp.h"
#include "Complex.h"

main()
{
    // Basic operators
  IdentityOperator Id;
  AnnihilationOperator A;
  NumberOperator N;
  Operator Ac = A.hc();

    // The Hamiltonian
  double omega = 1.0;
  Operator H = omega*Ac*A;

    // The Lindblad operators
  double gamma = 1.0;
  const int nOfLindblads = 1;
  Operator L1 = gamma*A;
  Operator L[nOfLindblads] = {L1};

    // The initial state
  int dim = 100;          // cutoff Hilbert space dimension
  int n = 5;
  Complex alpha(1.4,-0.4);
  State psi(dim,n);          // number state |n>
  // State psi(dim,alpha);   // coherent state |alpha>

    // The random number generator
  int seed = 74298;
  ACG gen(seed,55);
  ComplexNormal rand1(&gen);

    // Stepsize and integration time  
  double dt=0.01;   // basic time step
  int numdts=10;    // time interval between outputs = numdts*dt
  int numsteps=100; // total integration time = numsteps*numdts*dt
  
  double accuracy = 0.000001;

  AdaptiveStep theStepper(psi,H,nOfLindblads,L,accuracy);
    // deterministic part: adaptive stepsize 4th/5th order Runge Kutta
    // stochastic part: fixed stepsize Euler

//AdaptiveStochStep theStepper(psi,H,nOfLindblads,L,accuracy);
    // deterministic part: adaptive stepsize 4th/5th order Runge Kutta
    // stochastic part: Euler, 
    //      same (variable) stepsize as deterministic part

    // Output
  const int nOfOut = 2;
  Operator outlist[nOfOut] = {A,N};	    // Operators to output

  char *flist[nOfOut] = {"A.out","N.out"};  // Output files

  int pipe[4] = {1,2,5,7};
    // Standard output:
    // t,Re<A>,Im<A>,<N>,<N^2>-<N>^2,dim,steps
    //  where `t' is time, 
    // `dim' is the effective dimension of Hilbert space,
    //  and steps is the number of adaptive steps taken.
    //  (for more explanation see `onespin.cc')

    // Simulate one trajectory (for several trajectories, see `onespin.cc')
  Trajectory theTraject(psi,dt,theStepper,&rand1);
  theTraject.plotExp(nOfOut,outlist,flist,pipe,numdts,numsteps);
}


