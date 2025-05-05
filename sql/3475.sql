-- https://leetcode.com/problems/dna-pattern-recognition/description/

select
    *,
    case when dna_sequence ~ '^ATG' then 1 else 0 end as has_start,
    case when dna_sequence ~ 'T[AG]{2}$' then 1 else 0 end as has_stop,
    case when dna_sequence ~ 'ATAT' then 1 else 0 end as has_atat,
    case when dna_sequence ~ 'G{3,}' then 1 else 0 end as has_ggg

from samples

order by 1;