-- =====================================================
-- CREDIT RISK ANALYSIS
-- 09. EXECUTIVE SUMMARY
-- =====================================================

-- =====================================================
-- EXECUTIVE FINDINGS
-- =====================================================

-- Finding #1
-- Grade is the strongest predictor of default risk.
--
-- Default rates increase consistently from 3.49% in Grade A
-- to 39.97% in Grade G, confirming that Lending Club's
-- credit grading system effectively differentiates borrower risk.
--
-- Key Insight:
-- Credit grade is the primary driver of default probability
-- across the portfolio.


-- Finding #2
-- The largest financial losses are concentrated in Grade C,
-- not in the highest-risk grades.
--
-- While Grades F and G exhibit the highest default rates,
-- Grade C generates the highest estimated loss due to its
-- significantly larger funded exposure.
--
-- Estimated Loss by Grade:
-- Grade C: 1.35B
-- Grade D: 1.04B
-- Grade B: 765M
--
-- Key Insight:
-- The segments with the highest default rates are not
-- necessarily the segments that generate the largest losses.


-- Finding #3
-- Debt Consolidation represents the portfolio's largest source
-- of exposure and loss.
--
-- Portfolio Metrics:
-- - 1.27 million loans
-- - 20.26B funded amount
-- - 2.83B estimated loss
--
-- Debt Consolidation accounts for the largest share of both
-- lending activity and estimated losses across all loan purposes.
--
-- Key Insight:
-- Portfolio concentration can be as important as borrower risk
-- when assessing overall credit exposure.


-- Finding #4
-- Grade C borrowers seeking Debt Consolidation loans represent
-- the single most impactful risk segment in the portfolio.
--
-- Segment Metrics:
-- - 384,613 loans
-- - 6.09B funded amount
-- - 14.47% default rate
-- - 855M estimated loss
--
-- This segment generates the highest estimated loss of any
-- Grade-Purpose combination analyzed.
--
-- Key Insight:
-- Risk mitigation efforts should focus on segments that combine
-- meaningful default risk with large exposure levels.


-- Finding #5
-- Debt-to-Income Ratio (DTI) provides additional predictive power
-- even after controlling for borrower Grade.
--
-- Example:
-- Grade C:
-- Q1 DTI -> 12.54% default rate
-- Q4 DTI -> 15.24% default rate
--
-- Grade E:
-- Q1 DTI -> 24.25% default rate
-- Q4 DTI -> 30.13% default rate
--
-- Higher indebtedness is consistently associated with higher
-- default rates across multiple risk grades.
--
-- Key Insight:
-- DTI should be considered a complementary risk indicator
-- alongside credit grade.


-- =====================================================
-- BUSINESS RECOMMENDATIONS
-- =====================================================

-- Recommendation #1
-- Prioritize monitoring and portfolio reviews for Grades C and D,
-- as they contribute the largest share of estimated losses.


-- Recommendation #2
-- Strengthen underwriting criteria for Debt Consolidation loans,
-- particularly within medium- and high-risk grades.


-- Recommendation #3
-- Incorporate stricter Debt-to-Income thresholds into credit
-- approval policies to reduce default exposure.


-- Recommendation #4
-- Develop early-warning indicators for borrowers exhibiting
-- elevated DTI levels and weaker credit grades.


-- Recommendation #5
-- Allocate risk management resources based on estimated loss
-- exposure rather than default rate alone.


-- =====================================================
-- FINAL CONCLUSION
-- =====================================================
--
-- The analysis demonstrates that effective credit risk
-- management requires balancing both probability of default
-- and portfolio exposure.
--
-- Although high-risk grades exhibit the highest default rates,
-- the largest economic impact originates from highly
-- concentrated segments such as Grade C and Debt Consolidation.
--
-- The results suggest that risk mitigation strategies should
-- prioritize exposure-heavy segments while leveraging both
-- Grade and DTI as key risk indicators.
--
-- In summary, portfolio concentration, borrower credit quality,
-- and indebtedness levels jointly drive credit risk outcomes
-- within the Lending Club loan portfolio.
--
-- =====================================================