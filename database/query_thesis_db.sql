use thesis_db;

-- Example Query: Get vipassana motivation & Awareness change (Top 5 acc to awareness change)
SELECT 
    VD.ptag_vip,
    VD.vipassana_motivation,
    ROUND(((VD.awareness_after_vip - VD.awareness_before_vip) / VD.awareness_before_vip),
            2) AS awareness_change,
    TA.sentiment_polarity
FROM
    vipassana_details AS VD
        JOIN
    transcript_analysis AS TA ON VD.ptag_vip = TA.ptag_transcript
ORDER BY awareness_change DESC
LIMIT 5;
-- Analysis Part

-- Query 1: Lda Topic name along with keywords and analysis
SELECT 
    ldat.topic_name,
    GROUP_CONCAT(ldam.lda_topic_keyword
        ORDER BY ldam.kw_weight DESC
        SEPARATOR ', ') AS keywords,
    ldat.topic_analysis
FROM
    lda_topic_model ldat
        INNER JOIN
    lda_topic_makeup ldam ON ldat.topic_id = ldam.lda_topic_id
WHERE
    ldat.topic_id IN (0 , 1, 2, 3)
GROUP BY ldat.topic_name , ldat.topic_analysis;

-- Not included in thesis
SELECT 
    ta.ptag_transcript,
    ta.top_topic_name,
    ta.sentiment_polarity,
    ta.sentiment_subjectivity,
    bd.age,
    bd.employment_status,
    vd.vipassana_motivation,
    vd.obj_before_vip,
    vd.obj_after_vip
FROM 
    transcript_analysis ta
JOIN 
    basic_details bd ON ta.ptag_transcript = bd.tag
JOIN 
    vipassana_details vd ON ta.ptag_transcript = vd.ptag_vip
WHERE 
    ta.top_topic_id IS NOT NULL
ORDER BY 
    ta.top_topic_id, ta.sentiment_polarity DESC;
    
 -- Query 2: Number of respondents and Average Sentiment of Each Topic   
SELECT ta.top_topic_name , COUNT(ta.ptag_transcript) AS RespondentsInEachTopic, ROUND(AVG(ta.sentiment_polarity), 4) AS AvgSentiment
FROM transcript_analysis  ta
GROUP BY 1;

-- Query 3: Avg scores before and after vipassana 
SELECT 
	AVG(obj_before_vip),
    AVG(obj_after_vip),
    AVG(awareness_before_vip),
    AVG(awareness_after_vip),
    AVG(attachment_before_vip),
    AVG(attachment_after_vip),
    AVG(empathy_before_vip),
    AVG(empathy_after_vip),
    AVG(maitri_before_vip),
    AVG(maitri_after_vip)
FROM vipassana_details;

-- Query 4: Frequncy of Named Entities and bargraph
SELECT 
  SUM(org) AS total_org, 
  SUM(date) AS total_date, 
  SUM(person) AS total_person, 
  SUM(gpe) AS total_gpe, 
  SUM(cardinal) AS total_cardinal, 
  SUM(ordinal) AS total_ordinal 
FROM ner_freq;
-- Query 5: For sentiment subjectivity and top word of an individual
SELECT 
    ptag_transcript,
    top_word,
    top_word_freq,
    sentiment_subjectivity
FROM
    transcript_analysis;



