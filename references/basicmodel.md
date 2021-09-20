singapore:
--------
this is what our basic model looks like:

$$
n_t = \alpha_t N_t \chi_t 
$$
$$
N_{t+1} = N_t + n_t - \sum_i p_i n_{t-i}
$$

where $n_t$ is the new cases in day t , and $N_t$ is the all cases in day t . $p_i$ is the probability taht a person recover after i days. $\chi_t$ iid ~ E($\lambda$), which means:
$$
f(x) = \exp(-x)dx
$$

$α_t$ is what the all factors can affect the virus. we asume this parimeter will be the same under same condition.
so firstly we calculate $\alpha_t$ , ecause α can't change alot in a short time under our asumption but can still change smoothly , so we use something like MLE but a little different to get α ,
we change zhe likelyhood from :
$$
\sum_{i} ln(p_i)
$$
to:
$$
\frac{\sum_{i=t-n}^{t+n}\exp(-\frac{(i-t)^2}{\tau^2})*ln(p_i)}{\sum_{i=t-n}^{t+n}\exp(-\frac{(i-t)^2}{\tau^2})}
$$

so that for every t, we get a $\hat{\alpha_t}(\tau)$,if we chose τ too large or too small, α will contain nothing . we plot 10 $α_t(τ)$ choosen τ from 1~10 . then we chose manual from them to find the useful τ and α .

after getting α , we will do regrassion between α and the other factor, considering the meaning of α , independent factors should affect α by times eachother . so that:

$$
ln(\alpha) = \sum_if_i(θ_i) + \epsilon
$$

after regressinon we get some different functiions $f_i$ and can predict α from different factors {$θ_i$}, tant is $\alpha(\theta_i)$

then we predict different factors from knowledge , like  we can get wathers from last year's wather , we can get the relationship between goveronment index and the total number from experience and so on.

at last we use this factors and the result of regrassion to do simulation and get the final answer in singapore.



us or other place:
-------
only thing different is that because of the immigration policy not that strict. increase may because cases from other country,so we change $n_t$ a little bit:
$$
n_t = \alpha_t N^{in}_t \chi^{in}_t + \beta_t N^{out}_t \chi^{out}_t
$$
just like doing during get α ,we can get beta similarly .


regrassion details:
-----
