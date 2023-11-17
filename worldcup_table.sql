with cte as (
    SELECT team_1,
        count(*) as total_matches,
        (
            CASE
                WHEN team_1 = winner THEN 1
                else 0
            end
        ) as team_winner
    FROM icc_world_cup
    GROUP BY team_1,
        team_winner
)
SELECT *
FROM cte
    /* 
     𝐂𝐚𝐥𝐜𝐮𝐥𝐚𝐭𝐞 𝐭𝐨𝐭𝐚𝐥 𝐦𝐚𝐭𝐜𝐡𝐞𝐬 𝐩𝐥𝐚𝐲𝐞𝐝, 𝐰𝐢𝐧𝐬, 𝐝𝐫𝐚𝐰𝐬, 𝐥𝐨𝐬𝐬𝐞𝐬, 𝐚𝐧𝐝 𝐩𝐨𝐢𝐧𝐭𝐬 𝐟𝐨𝐫 𝐞𝐚𝐜𝐡 𝐭𝐞𝐚𝐦 ?
     url: https://media.licdn.com/dms/document/media/D4D1FAQF846lNiemQ3A/feedshare-document-pdf-analyzed/0/1697385879297?e=1698278400&v=beta&t=Ccn-gttqRsWdGCNknPsY030r3IA9NuIPNtxOOwOT0pc
     */