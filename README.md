# Hospital_Dashboard
Overview

The dashboard investigates why patient refusal rates vary drastically across hospital services despite steady patient satisfaction, and ties the answer back to bed capacity and staffing allocation. It's built from four raw datasets (patients, staff, staff schedules, and weekly service metrics) totaling ~7,870+ records.

File: Hospital_Dashboard.pbit (Power BI Template)

Data Sources

Table	Description
patients -	Individual patient records — arrival/departure dates, service, satisfaction score, length of stay
staff	- Staff roster — ID, name, type, service assignment
staff_schedule -	Weekly staff attendance by service and role
services_weekly	Weekly service-level metrics — beds available, patients requested/admitted/refused, satisfaction, staff morale
📄 Dashboard Pages
1. Patients — Hospital Operations: Optimizing Patient Flow & Workforce Utilization
KPI cards: Total Patients, Staff Present Rate, Admit Rate, Avg Satisfaction, Refusal Rate
Satisfaction by service (bar chart), Admitted vs. Refused split (donut), weekly demand vs. admissions trend, length-of-stay and age-group distributions
Key finding: The hospital admits only ~43% of weekly demand, turning away an average of 147 patients per week — a gap that widens during demand spikes (e.g., 574 requests in week 5's flu wave)
2. Staff — Workforce Analysis: Staffing Patterns & Service Coverage
KPI cards: Total Staff, Avg Staff Morale, Staff Attendance Rate, Avg Beds Per Service
Satisfaction vs. morale trend over time, patients-per-staff by service, staff-per-bed ratio by service
Key finding: ICU runs the richest staffing ratio (2.16 staff/bed) — nearly 4x General Medicine and Surgery (~0.58). Emergency sits at 1.27 staff/bed despite carrying the system's worst refusal rate (80.9%), pointing to a staffing allocation problem rather than an attendance problem (attendance holds steady at ~60% system-wide)
3. Services — Service Performance: Demand, Access & Outcomes
KPI cards: Total Admitted, Peak Month Demand, Zero-Refusal Weeks, Total System Beds
Satisfaction trend by service, monthly demand trend, admitted-share by service (donut), min/max refusal rate and bed range by service
Key finding: December sees an isolated demand spike (2,570 requests — 2.6x the monthly average). Emergency's refusal crisis is a bed-to-demand mismatch specific to that service, not a symptom of total system load — General Medicine and Surgery together admit ~70% of all patients

Core Insights
Emergency is structurally under-resourced relative to demand. Its refusal rate (up to ~77–81%) far outpaces ICU, General Medicine, and Surgery, while its staff-per-bed ratio sits mid-pack — not the lowest, but far short of what its demand requires.
Care quality doesn't drop where access does. Patient satisfaction stays steady (78–81.6) across every service regardless of refusal rate, meaning the disparity is entirely about who gets admitted, not the quality of care once admitted.
Refusal rate scales with demand-to-bed ratio. A fitted regression across weekly data estimates Refusal Rate ≈ 0.067 + 0.122 × (Requests ÷ Beds) (R² = 0.71), giving a quantified basis for capacity-planning decisions.
Attendance is stable; allocation is the lever. System-wide staff attendance (~60%) and morale (~72.6) show no alarming volatility — the real imbalance is in how staff are distributed across services, not whether they show up.

Built With
Power BI Desktop (data model, DAX measures, report pages)
DAX for custom measures: Admit Rate, Refusal Rate, Demand Capacity Ratio, Staff Per Bed, Staff Attendance Rate, and a regression-fitted Refusal Rate model, among others
Native Power BI visuals: KPI cards, clustered bar/column charts, donut charts, line charts, combo charts, slicers
