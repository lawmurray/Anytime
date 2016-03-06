/**
 * Lorenz '96 model.
 */
model Lorenz96 {
  dim n(size = 8, boundary = 'cyclic')

  const h = 0.05      // step size
  const minF = 0.0
  const maxF = 7.0
  const minS = 0.0
  const maxS = 0.02

  param F
  param sigma  // diffusion standard deviation
  state x[n]
  obs y[n]

  sub parameter {
    F ~ uniform(minF, maxF)
    sigma ~ uniform(minS, maxS);
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
    sigma ~ truncated_gaussian(sigma, 1.0e-3, minS, maxS);
  }

  sub proposal_initial {
    x[n] ~ gaussian(x[n], 1.0e-3)
  }
}
