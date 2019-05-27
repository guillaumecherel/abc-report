# ABC output report

Generate a report for the result of an ABC algorithm. 

Approximate Bayesian computation (ABC) aims at estimating the posterior density over a model parameters given some observed data. The R notebook `abc.Rmd` generates a report for the posterior density estimated by ABC:
$$f_{\Theta | Y = y_0}(\theta) \propto 
  f_{Y | \Theta = \theta}(y) f_\Theta(\theta)$$
where 

  - the random variable $\Theta = (\Theta_1, \cdots, \Theta_d) \in \mathbb{R}^d$ represents the model parameters,
  - the random variable $Y = (Y_1, \cdots, Y_l) \in \mathbb{R}^l$ represents the model output,
  - $y_0$ is the observed data.
  - $f_\Theta$ is the prior density for the model parameters.

The prior density is expected to be uniform over the rectangular region delimited by the two vectors $b_\textit{min} = (b_{\textit{min},1}, \cdots, b_{\textit{min},d}), b_\textit{max} = (b_{\textit{max},1}, \cdots, b_{\textit{max},d})\in \mathbb{R}^d$.

## Usage

Use the R package "rmarkdown" and the function render to generate the report. For example:

```{r}
library(rmarkdown)
render("abc.Rmd", output_file="report.html", 
  params=list(
    # path to the posterior sample
    datafile="path/to/datafile.csv",
    # column names of the parameters in the input file
    input_variables = c("theta0", "theta1", "theta2"),
    # prior density bounds
    prior_bounds = list(min=c(-10,-10), max=c(10,10)),
    # bandwidth 
    bandwidth = c(0.001, 0.001))))
```

The `params` is a list with the following elements:

- `datafile`: a path to a csv file representing the estimated posterior density. It is a weighted sample, each row represents one point and the columns are "theta1, ..., thetad, weight".
- `input_variable`: a vector of the colum names in the datafile which correspond to the variables of the model parameters.
- `prior_bounds`: a list with the elements `min` and `max` giving the bounds of the uniform prior. 
- `bandwidth`: a numeric vector of size d or NULL. Corresponds to the bandwidth parameters used by the kernel density estimates. If NULL, bandwidth are selected by the plug-in method implemented in the function `ks::Hpi.diag`

`


