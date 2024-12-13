# Nature-Inspired-DMU-Selection-and-Evaluation-in-Data-Envelopment-Analysis
Nature-Inspired DMU Selection and Evaluation in Data Envelopment Analysis

### Link to the paper:
- https://link.springer.com/chapter/10.1007/978-3-031-24475-9_17
- DOI: https://doi.org/10.1007/978-3-031-24475-9_17
### Please cite:
- Mousavi, Seyed Muhammad Hossein. "Nature-Inspired DMU Selection and Evaluation in Data Envelopment Analysis." The International Symposium on Computer Science, Digital Economy and Intelligent Systems. Cham: Springer Nature Switzerland, 2022.

# Nature-inspired DMU Selection and Evaluation in Data Envelopment Analysis

This repository contains the implementation of the research paper **"Nature-inspired DMU Selection and Evaluation in Data Envelopment Analysis"** by Seyed Muhammad Hossein Mousavi. The study explores the use of Biogeography-Based Optimization (BBO) for selecting Decision Management Units (DMUs) in Data Envelopment Analysis (DEA) to enhance system efficiency. It also introduces Fuzzy Firefly Regression for post-selection evaluation.


---

## Abstract
DMU selection is a critical step in optimizing efficiency in DEA. This research leverages nature-inspired optimization algorithms, particularly Biogeography-Based Optimization (BBO), to select the most effective DMUs for business and management datasets. Post-selection evaluation is performed using Fuzzy Firefly Regression, resulting in improved efficiency and correlation coefficients compared to traditional methods.

---

![f1](https://github.com/user-attachments/assets/bcca4d90-7684-4f4f-9374-632d14dbe773)

## Key Features
1. **Nature-inspired Optimization**:
   - Utilizes **Biogeography-Based Optimization (BBO)** for DMU selection.
   - Removes weak DMUs with high Mean Square Error (MSE) values.

2. **DEA Evaluation**:
   - Evaluates DMU efficiency using four DEA methods:
     - CCR
     - Input-Oriented BCC (IOBCC)
     - Output-Oriented BCC (OOBCC)
     - Additive models.

3. **Post-selection Regression**:
   - Applies **Fuzzy Firefly Regression** for enhanced correlation modeling.
   - Uses Fuzzy C-means clustering and Sugeno inference systems for optimization.

4. **Dataset Support**:
   - Works with various datasets, including:
     - Clickstream Data for Online Shopping
     - Daily Demand Forecasting Orders
     - Online News Popularity
     - Statlog (Australian Credit Approval).

---
![methods](https://github.com/user-attachments/assets/25d22225-655f-436c-b57f-a65b60fb7a69)
## Workflow

### Step 1: DMU Selection
- Input data is processed using the **BBO algorithm**.
- DMUs are ranked based on their efficiency and suitability for the system.

### Step 2: DEA Evaluation
- The selected DMUs are evaluated using DEA methods.
- Efficiency is calculated for subsets (25%, 50%, 75%) of the features.

### Step 3: Post-selection Regression
- Selected DMUs are used in **Fuzzy Firefly Regression**.
- The regression model is optimized using Firefly algorithm parameters (light intensity, absorption, and attraction coefficients).
![CCR and BCC models](https://github.com/user-attachments/assets/d23de702-a3e4-462c-bebf-6056111d11b6)


---

## Results

### DEA Results
| Method       | Rank (Features) | Clickstream | Daily Demand | Online News | Statlog |
|--------------|-----------------|-------------|--------------|-------------|---------|
| Original DEA | All             | 0.837       | 0.926        | 0.844       | 0.883   |
| Lasso DEA    | 25%            | 0.588       | 0.754        | 0.694       | 0.758   |
| GA DEA       | 25%            | 0.767       | 0.867        | 0.805       | 0.796   |
| PSO DEA      | 25%            | 0.772       | 0.876        | 0.800       | 0.856   |
| **BBO DEA**  | 25%            | **0.803**   | **0.900**    | **0.840**   | **0.883** |

### Regression Results
| Method               | Rank (Features) | CC (Train) | CC (Test) | MSE (Train) | MSE (Test) |
|----------------------|-----------------|------------|-----------|-------------|------------|
| Fuzzy Regression     | 25%            | 0.783      | 0.783     | 0.319       | 0.319      |
| **Fuzzy Firefly**    | 25%            | **0.987**  | **0.987** | **0.032**   | **0.032** |

---

## Algorithms Used

### Biogeography-Based Optimization (BBO)
- Parameters:
  - Iterations: 1000
  - Population: 20
  - Immigration Rate (λ): 0.3
  - Emigration Rate (μ): 0.2
  - Mutation Probability: 0.1
- Objective: Minimize MSE and select DMUs with the highest efficiency.

### Fuzzy Firefly Regression
- Parameters:
  - Population: 15
  - Iterations: 1000
  - Light Absorption Coefficient (γ): 0.1
  - Attraction Coefficient (β): 2
- Objective: Optimize fuzzy parameters for regression.

![Iteration](https://github.com/user-attachments/assets/d5c5a2a1-ec2e-47f7-9617-30c9c0e059f9)
![box](https://github.com/user-attachments/assets/8eeec80f-4a84-4624-9f4f-5e85f3f1f781)




![res2](https://github.com/user-attachments/assets/4a2870f4-1e34-4140-842f-9a2398b9e1dc)
![res](https://github.com/user-attachments/assets/334cd3f6-5016-4b44-b59c-bf778f01454d)
![finalres](https://github.com/user-attachments/assets/a8f75d1b-b476-44bc-a5d0-9f9a95c215c2)
