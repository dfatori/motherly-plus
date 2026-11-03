# Motherly Plus: Statistical Analysis Plan (SAP)

| | |
|---|---|
| **Trial title** | Motherly Plus: a randomized controlled trial evaluating a smartphone-assisted single-session psychotherapy intervention for postpartum depression |
| **Trial registration** | clinicaltrials.gov, ID number 97532226.8.0000.0068 |
| **Ethics approval** | CAPPesq, HC-FMUSP, CAAE 97532226.8.0000.0068 |
| **SAP version** | 1.0 |
| **SAP date** | 2026-11-03 |
| **Principal investigator** | Daniel Fatori |

This SAP specifies the analyses planned for the Motherly Plus trial and should be read alongside the study protocol. It will be finalized before database lock. Any deviation from it will be noted in the final study report.

## 1. Introduction

The primary objective is to test whether single-session psychotherapy supported by the Motherly app reduces postpartum depressive symptoms relative to a waitlist. Secondary objectives concern anxiety, sleep, parenting stress, functioning, and global clinical improvement. Moderator, mediator, and treatment-process objectives are addressed separately in §12.

## 2. Trial design

Motherly Plus is a parallel-group superiority trial with two groups and 1:1 allocation (intervention vs. waitlist). Participants are randomized through REDCap, using a list generated in R by an independent statistician, with no stratification. Assessments occur at T0 (screening), T1 (baseline, week 1), T2 (mid-treatment, week 2), T3 (post-treatment, week 4), and T4 (follow-up, week 8). Participants and clinicians cannot be masked, as is typical in psychotherapy trials, but outcome assessors will be masked to allocation, and the masked analyst will work from a dataset with masked group labels. Masking success will be checked at post-treatment using assessor guesses and confidence ratings.

## 3. Sample size

N = 104 (52 per group) was calculated from a meta-analytic effect size of g = 0.60 for single-session psychotherapy for depression (Metapsy database), two-sided α = 0.05, 80% power, and 15% anticipated dropout (G\*Power 3.1.9.4). See the protocol for the full derivation.

## 4. Statistical principles

All tests will be two-sided with α = 0.05, and we will report 95% confidence intervals for every estimate. The primary analysis will test a single contrast (waitlist minus intervention at T3) for the primary outcome. Each secondary outcome will likewise yield one contrast per timepoint (T3, T4). No interim analyses or stopping rules are planned. Protocol deviations, if any, will be identified, listed by participant, and summarized descriptively by group without affecting ITT membership.

## 5. Analysis populations

| Population | Definition | Use |
|---|---|---|
| Intention-to-treat (ITT) | All randomized participants, analyzed as allocated, with missing outcome data multiply imputed | Primary population for all efficacy analyses |
| Complete case | Participants with non-missing data at the timepoints a given outcome's model requires | Sensitivity analysis (§11) |
| Safety | All randomized participants | Adverse event summaries (§13) |

## 6. Trial population

Eligibility criteria are detailed in the protocol (Box 1): women 18–40 years old, up to 12 months postpartum, QIDS-SR16 ≥13, meeting DSM-5-TR criteria for major depressive disorder, literate in Brazilian Portuguese, owning an Android smartphone, and excluding severe/chronic mental disorders, current suicidal ideation or attempt, pregnancy loss, treatment-resistant depression, or recent pharmacotherapy/psychotherapy. Recruitment and flow through the trial will be summarized with a CONSORT diagram. Withdrawals and losses to follow-up will be tabulated by group and timing. Participants will remain in the ITT population unless they formally withdraw consent for use of their data.

Table 1 will summarize baseline characteristics by group: age, infant age, race, education, marital status, employment and studying status, family income, household size, number of children, firstborn status, prenatal visits, high-risk pregnancy, current mental health treatment, and baseline scores on all outcome measures (QIDS-C16, QIDS-SR16, GAD-7, SDS, EPDS, PSQI, PSI-SF and its subscales, CGI-S).

## 7. Outcomes

| Outcome | Definition | Timepoint(s) | Role |
|---|---|---|---|
| Depressive symptoms (clinician-rated) | Total score on the QIDS-C16, administered by masked assessors. Range 0–27; higher scores indicate more severe depression. | Week 4 (post-treatment, T3) | **Primary** |
| Depressive symptoms (self-report) | Total score on the QIDS-SR16. Range 0–27; higher scores indicate more severe depression. | Week 4 (T3) and week 8 (T4) | Secondary |
| Anxiety symptoms | Total score on the GAD-7. Range 0–21; higher scores indicate more severe anxiety. | Week 4 (T3) and week 8 (T4) | Secondary |
| Sleep problems | Global score on the PSQI. Range 0–21; higher scores indicate worse sleep quality. | Week 4 (T3) and week 8 (T4) | Secondary |
| Parental distress | Parental Distress subscale of the PSI-SF. Range 12–60; higher scores indicate more stress. | Week 4 (T3) and week 8 (T4) | Secondary |
| Parent-child dysfunctional interaction | Parent-Child Dysfunctional Interaction subscale of the PSI-SF. Range 12–60; higher scores indicate more stress. | Week 4 (T3) and week 8 (T4) | Secondary |
| Parenting stress | Total score of the PSI-SF. Range 36–180; higher scores indicate more stress. | Week 4 (T3) and week 8 (T4) | Secondary |
| Functional impairment | Total score on the SDS, covering work/school, social life, and family life. Range 0–30; higher scores indicate more impairment. | Week 4 (T3) and week 8 (T4) | Secondary |
| Change in depression severity and functional impairment relative to baseline | CGI-I, rated by masked assessors relative to baseline (T1). Range 1 (very much improved) to 7 (very much worse). | Week 4 (T3) | Secondary |
| Postnatal depressive symptoms (EPDS) | Total score on the EPDS. Range 0–30; higher scores indicate more symptoms. Used for comparison with the PPD literature. | Week 4 (T3) and week 8 (T4) | Secondary |

## 8. Missing data

Missing outcome data will be handled with multiple imputation by chained equations (MICE), under a missing-at-random assumption. A single imputation model will be fit across all randomized participants (ITT), with `group` included as a predictor. Remaining predictors are selected via `mice::quickpred` (|r| ≥ 0.2): age, infant age, race, education, marital status, family income, current mental health treatment, baseline CGI-S, and the available timepoint scores of every outcome. Continuous scores will be imputed by predictive mean matching and CGI-I as an ordinal variable. We will use m = 100 imputations and 20 iterations with a fixed seed. Graham et al. (2007) show this keeps power loss under 1% for a fraction of missing information up to 0.7, which we will check per parameter, increasing m if exceeded. Estimates will be combined across imputations with Rubin's rules.

## 9. Primary outcome analysis

QIDS-C16 at T1 and T3 will be analyzed with a generalized estimating equations (GEE) model, AR(1) working correlation, and a robust sandwich variance estimator, following Twisk et al. (2018, eq. 2d):

```
qidsc16 ~ T3 + T3:group
```

There will be no main effect of `group`: T1 is the shared intercept, assumed equal between groups by randomization, and the treatment effect at T3 is the `T3:group` coefficient. The model will be fit once per imputed dataset and pooled with Rubin's rules. We will report estimated marginal means by group at T1 and T3, the waitlist-minus-intervention contrast at T3 with its 95% CI and p-value, and Cohen's d (the contrast divided by the pooled within-group SD at T3, averaged across imputations).

## 10. Secondary outcomes analysis

The same GEE specification will be applied to QIDS-SR16, GAD-7, PSQI, the three PSI-SF scores, SDS, and EPDS at T3 and T4:

```
outcome ~ T3 + T4 + T3:group + T4:group
```

Marginal means, contrasts, and Cohen's d will be reported at T3 and T4 as in §9. CGI-I, which has no baseline, will be imputed as ordinal but analyzed as a continuous 1–7 score with a linear regression on `group`, pooled with Rubin's rules, and reported in the same way as the other outcomes.

## 11. Sensitivity analysis

As a sensitivity check on the influence of missing data, we will repeat the primary and secondary analyses on observed data only, fitting each model once instead of across imputations. For each outcome, participants with any missing value at the timepoints that outcome's model requires will be excluded beforehand, so the set of participants analyzed will differ slightly by outcome. The number analyzed and excluded will be reported alongside the usual estimates.

## 12. Moderator, mediator, and process analyses

We also plan moderator analyses (age, income, education, baseline severity, among others), mediation analyses (BADS-SF, RPI), and treatment-process analyses (WAI-SR therapeutic alliance, Motherly app engagement). These are not pre-registered and are considered exploratory.

## 13. Safety and adverse events

We will define clinical worsening as an increase of 30% or more in the QIDS-16 total score (clinician-rated or self-report) at T3 or T4 relative to baseline, and a serious adverse event as death, a life-threatening event, hospitalization or its prolongation, significant or persistent disability, or another clinically significant event. Suicide risk will be flagged by a QIDS-16 item 12 score of 2 or more at any post-baseline assessment. Adverse events and serious adverse events will be summarized descriptively by group (n, %). Serious events and suicide-risk flags will also be listed individually with timepoint and action taken.

## 14. Software

Analyses will be run in R, using `geepack` for the GEE models, `mice` for multiple imputation, `emmeans` for marginal means, contrasts, and effect sizes, `broom` for tidying the complete-case models, and `gtsummary`/`flextable` for tables.

## 15. Revision history

| Version | Date | Author | Summary |
|---|---|---|---|
| 1.0 | 2026-11-03 | Daniel Fatori, Pedro Zuccolo | Initial version |

## References

- Twisk J, et al. Different ways to estimate treatment effects in randomised controlled trials. *Contemp Clin Trials Commun*. 2018;10:153-159.
- Rubin DB. *Multiple Imputation for Nonresponse in Surveys*. Wiley; 1987/2004.
- Graham JW, Olchowski AE, Gilreath TD. How many imputations are really needed? *Prev Sci*. 2007;8(3):206-213.