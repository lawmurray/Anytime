/**
 * Lorenz '96 model.
 */
model Lorenz96 {
  dim n(size = 8, boundary = 'cyclic')

  const h = 0.05      // step size
  const sigma = 0.01  // process noise
  const minF = 0.0
  const maxF = 7.0

  param F
  state x[n]
  obs y[n]

  sub parameter {
    F ~ uniform(minF, maxF)
  }

  sub initial {
    x[n] ~ gaussian(0.0, sigma)
  }

  sub transition(delta = h) {
    ode(alg = 'RK4(3)', h = h, atoler = 1.0e-4, rtoler = 1.0e-6) {
      dx[n]/dt = x[n-1]*(x[n+1] - x[n-2]) - x[n] + F
    }
    x[n] ~ gaussian(x[n], sigma*sqrt(h))
  }

  sub observation {
    y[n] ~ normal(x[n], 0.5)
  }

  sub proposal_parameter {
    F ~ truncated_gaussian(F, 1.0e-3, minF, maxF);
  }

  sub proposal_initial {
    x[n] ~ gaussian(x[n], 1.0e-3)
  }
}
