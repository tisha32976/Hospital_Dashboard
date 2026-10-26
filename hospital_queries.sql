SELECT
    service,
    SUM(patients_request)  AS total_requests,
    SUM(patients_admitted) AS total_admitted,
    SUM(patients_refused)  AS total_refused,
    ROUND(SUM(patients_refused) * 100.0 / SUM(patients_request), 1) AS refusal_rate_pct
FROM services_weekly
GROUP BY service
ORDER BY refusal_rate_pct DESC;

--Emergency turns away 80.9% of requests, over 4x ICU’s 17.9%, with General Medicine at 45.4% and Surgery at 24.8%.

SELECT
    SUM(patients_request)  AS total_requests,
    SUM(patients_admitted) AS total_admitted,
    SUM(patients_refused)  AS total_refused,
    ROUND(SUM(patients_admitted) * 100.0 / SUM(patients_request), 1) AS admit_rate_pct,
    ROUND(SUM(patients_refused)  * 100.0 / SUM(patients_request), 1) AS refusal_rate_pct
FROM services_weekly;

--Across all services, only 43.4% of requests are admitted and 56.6% are refused.

SELECT
    service,
    ROUND(AVG(available_beds), 1)     AS avg_beds,
    ROUND(AVG(patients_request), 1)   AS avg_weekly_requests,
    ROUND(SUM(patients_request) * 1.0 / SUM(available_beds), 2) AS demand_to_capacity_ratio
FROM services_weekly
GROUP BY service
ORDER BY demand_to_capacity_ratio DESC;

--Emergency has the highest pressure, at roughly 5 requests per bed, and it also has the highest refusal rate.
--The ranking matches Q1, so capacity pressure tracks refusals.

SELECT DISTINCT event FROM services_weekly;
SELECT
    week,
    SUM(patients_request) AS total_requests,
    SUM(patients_refused) AS total_refused,
    ROUND(SUM(patients_refused) * 100.0 / SUM(patients_request), 1) AS refusal_rate_pct
FROM services_weekly
GROUP BY week
ORDER BY total_refused DESC
LIMIT 5;

--Week 5 is the worst, with 470 refusals (81.9%). Weeks 12, 51, 1 and 2 follow.
--Weeks 51, 1 and 2 sit around the year boundary, so check whether they coincide with flu weeks in the event column before claiming a seasonal pattern.

SELECT
    event,
    COUNT(*) AS service_weeks,
    ROUND(SUM(patients_refused) * 100.0 / SUM(patients_request), 1) AS refusal_rate_pct,
    ROUND(AVG(patient_satisfaction), 1) AS avg_satisfaction,
    ROUND(AVG(staff_morale), 1) AS avg_morale
FROM services_weekly
GROUP BY event
ORDER BY refusal_rate_pct DESC;

--Flu weeks push refusals to 78.2%, against a 50.5% baseline.
--Strike weeks drop morale to 53.7, against a 73.1 baseline.
--Refusal rate was lower during strikes (41.0%), and satisfaction didn’t fall.
--Don’t claim a strike worsens care from this. It rests on only 11 service-weeks.

SELECT
    month,
    service,
    SUM(patients_request) AS total_requests,
    SUM(patients_refused) AS total_refused,
    ROUND(SUM(patients_refused) * 100.0 / SUM(patients_request), 1) AS refusal_rate_pct
FROM services_weekly
GROUP BY month, service
ORDER BY month, service;

SELECT
    service,
    role,
    COUNT(*) AS schedule_rows,
    ROUND(AVG(present) * 100.0, 1) AS attendance_pct
FROM staff_schedule
GROUP BY service, role
ORDER BY attendance_pct DESC;

--Attendance sits at about 59–60% across every role and service.
-- Staffing levels barely vary, so attendance can’t explain why refusals differ by service

WITH weekly AS (
    SELECT
        week,
        service,
        patients_refused * 100.0 / patients_request AS refusal_rate
    FROM services_weekly
    WHERE patients_request > 0
),
with_avg AS (
    SELECT
        week,
        service,
        refusal_rate,
        AVG(refusal_rate) OVER (PARTITION BY service) AS service_avg
    FROM weekly
)
SELECT
    service,
    week,
    ROUND(refusal_rate, 1) AS refusal_rate_pct,
    ROUND(service_avg, 1)  AS service_avg_pct,
    ROUND(refusal_rate - service_avg, 1) AS gap_pts
FROM with_avg
WHERE refusal_rate > service_avg
ORDER BY gap_pts DESC
LIMIT 10;