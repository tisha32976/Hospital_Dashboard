Overview-

Investigates why patient refusal rates vary drastically across hospital services despite steady patient satisfaction
Ties the answer back to bed capacity and staffing allocation
Built from four raw datasets (patients, staff, staff schedules, weekly service metrics) totaling ~7,870+ records
File: Hospital_Dashboard.pbit (Power BI Template)

Data Sources-

patients — individual patient records: arrival/departure dates, service, satisfaction score, length of stay
staff — staff roster: ID, name, type, service assignment
staff_schedule — weekly staff attendance by service and role
services_weekly — weekly service-level metrics: beds available, patients requested/admitted/refused, satisfaction, staff morale

Dashboard Pages-

1. Patients — Optimizing Patient Flow & Workforce Utilization
KPI cards: Total Patients, Staff Present Rate, Admit Rate, Avg Satisfaction, Refusal Rate
Satisfaction by service (bar chart)
Admitted vs. Refused split (donut)
Weekly demand vs. admissions trend
Length-of-stay and age-group distributions
Key finding: the hospital admits only ~43% of weekly demand, turning away an average of 147 patients per week — a gap that widens during demand spikes (e.g., 574 requests in week 5's flu wave)
2. Staff — Workforce Analysis: Staffing Patterns & Service Coverage
KPI cards: Total Staff, Avg Staff Morale, Staff Attendance Rate, Avg Beds Per Service
Satisfaction vs. morale trend over time
Patients-per-staff by service
Staff-per-bed ratio by service
Key finding: ICU runs the richest staffing ratio (2.16 staff/bed) — nearly 4x General Medicine and Surgery (~0.58). Emergency sits at 1.27 staff/bed despite carrying the system's worst refusal rate (80.9%), pointing to a staffing allocation problem rather than an attendance problem (attendance holds steady at ~60% system-wide)
3. Services — Service Performance: Demand, Access & Outcomes
KPI cards: Total Admitted, Peak Month Demand, Zero-Refusal Weeks, Total System Beds
Satisfaction trend by service
Monthly demand trend
Admitted-share by service (donut)
Min/max refusal rate and bed range by service
Key finding: December sees an isolated demand spike (2,570 requests — 2.6x the monthly average). Emergency's refusal crisis is a bed-to-demand mismatch specific to that service, not a symptom of total system load — General Medicine and Surgery together admit ~70% of all patients

Core Insights-

Emergency is structurally under-resourced relative to demand — its refusal rate (up to ~77–81%) far outpaces ICU, General Medicine, and Surgery, while its staff-per-bed ratio sits mid-pack, far short of what its demand requires
Care quality doesn't drop where access does — patient satisfaction stays steady (78–81.6) across every service regardless of refusal rate, meaning the disparity is entirely about who gets admitted, not the quality of care once admitted
Refusal rate scales with demand-to-bed ratio — a fitted regression across weekly data estimates Refusal Rate ≈ 0.067 + 0.122 × (Requests ÷ Beds) (R² = 0.71), giving a quantified basis for capacity-planning decisions
Attendance is stable; allocation is the lever — system-wide staff attendance (~60%) and morale (~72.6) show no alarming volatility; the real imbalance is in how staff are distributed across services, not whether they show up

Built With-

Power BI Desktop — data model, DAX measures, report pages
DAX — custom measures including Admit Rate, Refusal Rate, Demand Capacity Ratio, Staff Per Bed, Staff Attendance Rate, and a regression-fitted Refusal Rate model
Native Power BI visuals — KPI cards, clustered bar/column charts, donut charts, line charts, combo charts, slicers

How to Use-

Download Hospital_Dashboard.pbit
Open in Power BI Desktop.
When prompted, point it to the four source CSVs (patients.csv, staff.csv, staff_schedule.csv, services_weekly.csv) or load your own data in the same schema
Explore the three report pages using the service slicer to filter by Emergency, ICU, General Medicine, or Surgery
 Notes
This is a portfolio/analytics project built to demonstrate end-to-end dashboard design: data modeling, DAX measure development, and insight-driven storytelling
The regression fit (R² = 0.71) is a simplified model meant to illustrate the demand-capacity relationship, not a validated clinical/operations model

Screenshots-

https://github.com/tisha32976/Hospital_Dashboard/blob/main/Screenshot%202026-09-15%20211909.png
