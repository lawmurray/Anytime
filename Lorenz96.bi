/**
 * Lorenz '96 model.
 */
model Lorenz96 {
  dim n(size = 8, boundary = 'cyclic')

  const h = 0.05      // step size
  const sigma = 0.25  // diffusion standard deviation
  const minF = 0.0
  const maxF = 7.0

  param F                          // forcing
  state x[n]                       // state variables
  noise deltaW[n](has_output = 0)  // Wiener process increments
  obs y[n]                         // observations

  sub parameter {
    F ~ uniform(minF, maxF)
  }

  sub initial {
    x[n] ~ gaussian(0.0, F/3.0)
  }

  sub transition(delta = h) {
    deltaW[n] ~ wiener()
    ode(alg = 'RK4(3)', h = h, atoler = 1.0e-4, rtoler = 1.0e-4) {
      dx[n]/dt = x[n-1]*(x[n+1] - x[n-2]) - x[n] + F + sigma*deltaW[n]/h
    }
  }

  sub observation {
    y[n] ~ normal(x[n], 0.5)
  }

  sub proposal_parameter {
    F ~ truncated_gaussian(F, 1.0e-4, minF, maxF);
  }

  sub proposal_initial {
    x[n] ~ gaussian(x[n], 1.0e-4)
  }
}
