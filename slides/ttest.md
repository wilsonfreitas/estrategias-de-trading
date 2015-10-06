---

title       : Propriedades de estimadores e testes estatísticos simples  
subtitle    :   
author      : Wilson Freitas  
job         : Quant  
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}  
highlighter : highlight.js  # {highlight.js, prettify, highlight}  
hitheme     : tomorrow      #   
widgets     : [mathjax]     # {mathjax, quiz, bootstrap}  
mode        : selfcontained # {standalone, draft}  

--- &smaller
## Estimadores

- Seja uma variável aleatória $X$.
- Temos $\theta = g(X)$, uma função da variável aleatória, que retorna um número real.
- Consideremos agora uma amostra aleatória ${x_i}$ da variável aleatória $X$.
- A amostra ${x_i}$ é um conjunto que pertence a $\sigma$-álgebra de $X$, ou seja, é um evento possível dentro do seu espaço probabilístico.
- Ao calcularmos $\theta$ para a amostra ${x_i}$, vamos chamar este resultado de $\hat{\theta}$, estaremos obtendo um evento possível que pertence ao espaço probabilístico de $\theta$, logo, $\hat{\theta} \in \cal{f}_{\theta}$, onde $\cal{f}_{\theta}$ é a $\sigma$-álgebra de $\theta$.
- Desta forma, para novas amostras ${x_i}$ obteremos diferentes valores para $\hat{\theta}$, e portanto, assim com a amostra é aleatória os resuldados de $\hat{\theta}$ para estas amostras também o são.

$$
\begin{split}
\theta: & \textrm{parâmetro a ser estimado, número real}\\
\hat{\theta}: & \textrm{estimador do parâmetro, variável aleatória}
\end{split}
$$

---
## Propriedades de estimadores

- $\hat{\theta}$ é uma variável aleatória
- $\hat{\theta} \sim f(\hat{\theta})$ que é a função de densidade de probabilidade (fdp) de $\hat{\theta}$ (estou considerando apenas variáveis aleatórias reais). Esta fdp pode ser encontrada analiticamente ou através de simulação de Monte-Carlo.
- Erro de estimação: 
$$
error(\hat{\theta}, \theta) = \hat{\theta} - \theta
$$
- Valor esperado do erro de estimação (viés/bias):
$$
bias(\hat{\theta}, \theta) = E[error(\hat{\theta}, \theta)] = E[\hat{\theta} - \theta] = E[\hat{\theta}] - \theta
$$
- $\hat{\theta}$ é não-viesado se $bias(\hat{\theta}, \theta) = 0$, logo, $E[\hat{\theta}] = \theta$

---
## Propriedades de estimadores

- Erro médio padrão (mse - mean standard error):
$$
\begin{split}
mse(\hat{\theta}, \theta) &= E[error^2(\hat{\theta}, \theta)] \\
&= E[(\hat{\theta}-\theta)^2] \\
&= E[\hat{\theta}^2 - 2\hat{\theta}\theta + \theta^2] \\
&= E[\hat{\theta}^2] - 2E[\hat{\theta}]\theta + \theta^2 \\
&= E[\hat{\theta}^2] - E^2[\hat{\theta}] + E^2[\hat{\theta}] - 2E[\hat{\theta}]\theta + \theta^2 \\
&= \sigma^2_{\hat{\theta}} + bias^2(\hat{\theta}, \theta)\\
\end{split}
$$
- Note que $bias(\hat{\theta}, \theta) = 0 \Longrightarrow mse(\hat{\theta}, \theta) = \sigma^2_{\hat{\theta}}$
- Erro padrão (se - standard error):
$$
se(\hat{\theta}) = \sqrt{\sigma^2_{\hat{\theta}}}
$$

---
## Características importantes de estimadores


- Bons estimadores tem pouco viés e pequeno erro padrão
- Precisão:
$$
\begin{split}
\textrm{erro padrão grande}  &\longrightarrow \textrm{pior precisão} \\
\textrm{erro padrão pequeno} &\longrightarrow \textrm{melhor precisão}
\end{split}
$$
- precisão aumenta com o tamanho da amostra
$$
T \longrightarrow \infty \Longrightarrow se(\hat{\theta}) \longrightarrow 0
$$

---
## Teste t

Seja a variável aleatória $Y \sim iid N(\mu, \sigma^2)$.
Sabemos que a variável
Para uma amostra $\{y_i\}_{i \in N}$ queremos testar se o estimador $\hat{\mu}$ é igual ao parâmetro a $\mu$.
Para tanto realizamos um teste com a estatística $t(\hat{\mu}, \mu)$ dada por:

$$
t(\hat{\mu}, \mu) = \frac{error(\hat{\mu}, \mu)}{se(\hat{\mu})} = \frac{\hat{\mu} - \mu}{se(\hat{\mu})}
$$


