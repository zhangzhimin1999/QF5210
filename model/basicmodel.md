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


simulation details:
---


uneployment:
---
talking about unemployment , we believe there is 3 main reasons : macro economy , government attitude , and the covid sitruation . they may have correlation themselves , but they will affect unenployment independently , let U means unenployment , let i length vctor E means macro economy , let j length vctor G means goveronment's reaction toward them.

mathly speaking , because we believe unenployment can't get too high , the PDE between E,G,U must be dominated by some mechenisam that can push back the too high U.
but since assuming that PDE is a linear one is naive and unreasonable , and the PDE may also change during a long proid . 

so the only thing we can do to get some info of the solution of that PDE , is to learn about the data from 2020apr on.

thanks god , after we do DFT , we observed a strong patern in the spectrum : there is nothing significent if ν > ν$_0$ where:
$$
ν_0 = 0.1875^{-month} .
$$
this means that the they may probably be the noise . we canuse a filter function to reduce them .

if we want a more effencient filter , we may first do interpolation on the row data . then we use a low-pass filter to reduce the noise . by chosing different interpolation methord and low-pass filter function , we can get different U$_t$ time serious. 

we can select the most useful one by the evalution payoff function:

$$
P = \sum_{i|u_i\ maches\  u_{i0}\ in\ raw\ data}(u_i - u_i0)^2*e^{-(i0-17)^2*\nu_0^2/2}
$$ 

that means for the No.k parimeter θₖ in interpolation and filter :
$$
\frac{\partial{P}}{\partial{θₖ}} = 0
$$
applying this {θₖ} , we get our final Uₜ from all of what we get. 
at last we do polynomino regression on  this final Uₜ ~ t:
$$
U(t) = U(t₀) + \sum_ic_i(t-t_0)^i
$$
since this is a local regrassion , we can't chose Uₜ for too long , we chose t from [t₀ - Δt] where:
$$
(ν₀Δt)^{i}/(1-ν₀Δt) < 0.1 
$$
if do rank i polynomino regrassion.

after regrassion ,we get cᵢ and can predict $U(t_0 + δt)$ where δt follow the same criteria with Δt.






