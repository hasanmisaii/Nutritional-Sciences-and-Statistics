# Nutritional-Sciences-and-Statistics (a study using INCA3 ("Étude Individuelle Nationale des Consommations Alimentaires 3") data)
This repository includes subjects like:

* INCA3 data
  * https://www.anses.fr/en/content/raw-data-ansess-inca-3-study-now-available
  * https://www.data.gouv.fr/datasets/donnees-de-consommations-et-habitudes-alimentaires-de-letude-inca-3/

* Usual Intake Distribution Estimation
  * Crossed Random Effects Model 
  
     $$g(Y_{ij}) = \beta_0 + X_i^T B + \theta_i + t_j + \epsilon_{ij} $$
    
  * Random Effects Model
    
     $$g(Y_{ij}) = \beta_0 + X_i^T B + \theta_i + \epsilon_{ij} $$

  * Temporal Variational Model

    $$g(Y_{ij}) = \beta_0 + X_i^T B + t_j + \epsilon_{ij} $$

  * Traditional Regression Model

    $$g(Y_{ij}) = \beta_0 + X_i^T B + \epsilon_{ij} $$

  * Nested Random Effects Model
 



   $$g(Y_{ij}) = \beta_0 + X_i^T B + \theta_i + t_{j(i)} + \epsilon_{ij} $$
  

* Life expectancy modeling 

