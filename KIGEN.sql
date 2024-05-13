SELECT 
       AD.ASSET_ID ASSET_ID_MASTER,
       AD.ASSET_NUMBER,
       AD2.DESCRIPTION,
       CAT_FLEX_ALL_SEG Category_Segments,
       CAT.DESCRIPTION CATEGORY_DESC,
       AD.MANUFACTURER_NAME,
       AD.TAG_NUMBER,
       AD.SERIAL_NUMBER,
       AD.MODEL_NUMBER,
       LOOKUPS_PT.MEANING PROPERTY_TYPE,
       LOOKUPS_12.MEANING PROPERTY_1245_1250,
       LOOKUPS_IU.MEANING IN_USE_FLAG,
       LOOKUPS_OL.MEANING OWNED_LEASED,
       LOOKUPS_NU.MEANING NEW_USED,
       NULL               PARENT_ASSET_NUMBER,
       NULL               PARENT_ASSET_DESC,
       LOOKUPS_AT.MEANING ASSET_TYPE, 
       AD.CURRENT_UNITS
FROM    
       FA_ASSET_HISTORY AH,
       FA_BOOKS         BK,
       FA_CATEGORIES    CAT,
       FA_LOOKUPS       LOOKUPS_AT,
       FA_LOOKUPS       LOOKUPS_NU,
       FA_LOOKUPS       LOOKUPS_OL,
       FA_LOOKUPS       LOOKUPS_IU,
       FA_LOOKUPS       LOOKUPS_PT,
       FA_LOOKUPS       LOOKUPS_12,
       FA_ADDITIONS_TL  AD2,
       FA_ADDITIONS_B   AD
WHERE    
       :P_START_ASSET IS NOT NULL                             AND
       :P_END_ASSET IS NOT NULL                               AND
       AD.ASSET_NUMBER BETWEEN :P_START_ASSET AND :P_END_ASSET
AND
       AD.ASSET_ID = AD2.ASSET_ID                             AND
       AD.PARENT_ASSET_ID IS NULL                             AND
       AD2.LANGUAGE = userenv('LANG')                         AND
       AH.ASSET_ID    = AD.ASSET_ID                           AND
       AH.DATE_EFFECTIVE    <= SYSDATE                        AND
       NVL(AH.DATE_INEFFECTIVE, SYSDATE+1) > SYSDATE
AND
       AH.CATEGORY_ID = CAT.CATEGORY_ID
AND
       BK.ASSET_ID       =  AD.ASSET_ID                        AND
       BK.BOOK_TYPE_CODE  =  :BOOK                             AND
       BK.DATE_INEFFECTIVE IS NULL             
AND
       LOOKUPS_AT.LOOKUP_CODE = AD.ASSET_TYPE                  AND
       LOOKUPS_AT.LOOKUP_TYPE = 'ASSET TYPE'                   AND
       LOOKUPS_NU.LOOKUP_CODE = AD.NEW_USED                    AND
       LOOKUPS_NU.LOOKUP_TYPE = 'NEWUSE'                       AND
       LOOKUPS_OL.LOOKUP_CODE = AD.OWNED_LEASED                AND
       LOOKUPS_OL.LOOKUP_TYPE = 'OWNLEASE'                     AND
       LOOKUPS_IU.LOOKUP_CODE = AD.IN_USE_FLAG                 AND
       LOOKUPS_IU.LOOKUP_TYPE = 'YESNO'                        AND
       LOOKUPS_PT.LOOKUP_CODE(+) = AD.PROPERTY_TYPE_CODE       AND
       LOOKUPS_PT.LOOKUP_TYPE(+) = 'PROPERTY TYPE'             AND
       LOOKUPS_12.LOOKUP_CODE(+) = AD.PROPERTY_1245_1250_CODE  AND
       LOOKUPS_12.LOOKUP_TYPE(+) = '1245/1250 PROPERTY'
UNION ALL
SELECT 
       AD.ASSET_ID ASSET_ID_MASTER,
       AD.ASSET_NUMBER,
       AD2.DESCRIPTION,
       &CAT_FLEX_ALL_SEG Category_Segments,
       CAT.DESCRIPTION CATEGORY_DESC,
       AD.MANUFACTURER_NAME,
       AD.TAG_NUMBER,
       AD.SERIAL_NUMBER,
       AD.MODEL_NUMBER,
       LOOKUPS_PT.MEANING PROPERTY_TYPE,
       LOOKUPS_12.MEANING PROPERTY_1245_1250,
       LOOKUPS_IU.MEANING IN_USE_FLAG,
       LOOKUPS_OL.MEANING OWNED_LEASED,
       LOOKUPS_NU.MEANING NEW_USED,
       NULL               PARENT_ASSET_NUMBER,
       NULL               PARENT_ASSET_DESC,
       LOOKUPS_AT.MEANING ASSET_TYPE, 
       AD.CURRENT_UNITS
FROM    
       FA_ASSET_HISTORY AH,
       FA_BOOKS         BK,
       FA_CATEGORIES    CAT,
       FA_LOOKUPS       LOOKUPS_AT,
       FA_LOOKUPS       LOOKUPS_NU,
       FA_LOOKUPS       LOOKUPS_OL,
       FA_LOOKUPS       LOOKUPS_IU,
       FA_LOOKUPS       LOOKUPS_PT,
       FA_LOOKUPS       LOOKUPS_12,
       FA_ADDITIONS_TL  AD2,
       FA_ADDITIONS_B   AD 
WHERE    
       :P_START_ASSET IS NULL                                 AND
       :P_END_ASSET IS NOT NULL                               AND
       AD.ASSET_NUMBER BETWEEN AD.ASSET_NUMBER AND :P_END_ASSET
AND
       AD.ASSET_ID = AD2.ASSET_ID                             AND
       AD.PARENT_ASSET_ID IS NULL                             AND
       AD2.LANGUAGE = userenv('LANG')                         AND
       AH.ASSET_ID    = AD.ASSET_ID                           AND
       AH.DATE_EFFECTIVE    <= SYSDATE                        AND
       NVL(AH.DATE_INEFFECTIVE, SYSDATE+1) > SYSDATE
AND
       AH.CATEGORY_ID = CAT.CATEGORY_ID
AND
       BK.ASSET_ID       =  AD.ASSET_ID                        AND
       BK.BOOK_TYPE_CODE  =  :BOOK                             AND
       BK.DATE_INEFFECTIVE IS NULL             
AND
       LOOKUPS_AT.LOOKUP_CODE = AD.ASSET_TYPE                  AND
       LOOKUPS_AT.LOOKUP_TYPE = 'ASSET TYPE'                   AND
       LOOKUPS_NU.LOOKUP_CODE = AD.NEW_USED                    AND
       LOOKUPS_NU.LOOKUP_TYPE = 'NEWUSE'                       AND
       LOOKUPS_OL.LOOKUP_CODE = AD.OWNED_LEASED                AND
       LOOKUPS_OL.LOOKUP_TYPE = 'OWNLEASE'                     AND
       LOOKUPS_IU.LOOKUP_CODE = AD.IN_USE_FLAG                 AND
       LOOKUPS_IU.LOOKUP_TYPE = 'YESNO'                        AND
       LOOKUPS_PT.LOOKUP_CODE(+) = AD.PROPERTY_TYPE_CODE       AND
       LOOKUPS_PT.LOOKUP_TYPE(+) = 'PROPERTY TYPE'             AND
       LOOKUPS_12.LOOKUP_CODE(+) = AD.PROPERTY_1245_1250_CODE  AND
       LOOKUPS_12.LOOKUP_TYPE(+) = '1245/1250 PROPERTY'
UNION ALL
SELECT 
       AD.ASSET_ID ASSET_ID_MASTER,
       AD.ASSET_NUMBER,
       AD2.DESCRIPTION,
       &CAT_FLEX_ALL_SEG Category_Segments,
       CAT.DESCRIPTION CATEGORY_DESC,
       AD.MANUFACTURER_NAME,
       AD.TAG_NUMBER,
       AD.SERIAL_NUMBER,
       AD.MODEL_NUMBER,
       LOOKUPS_PT.MEANING PROPERTY_TYPE,
       LOOKUPS_12.MEANING PROPERTY_1245_1250,
       LOOKUPS_IU.MEANING IN_USE_FLAG,
       LOOKUPS_OL.MEANING OWNED_LEASED,
       LOOKUPS_NU.MEANING NEW_USED,
       NULL               PARENT_ASSET_NUMBER,
       NULL               PARENT_ASSET_DESC,
       LOOKUPS_AT.MEANING ASSET_TYPE, 
       AD.CURRENT_UNITS
FROM    
       FA_ASSET_HISTORY AH,
       FA_BOOKS         BK,
       FA_CATEGORIES    CAT,
       FA_LOOKUPS       LOOKUPS_AT,
       FA_LOOKUPS       LOOKUPS_NU,
       FA_LOOKUPS       LOOKUPS_OL,
       FA_LOOKUPS       LOOKUPS_IU,
       FA_LOOKUPS       LOOKUPS_PT,
       FA_LOOKUPS       LOOKUPS_12,
       FA_ADDITIONS_TL  AD2,
       FA_ADDITIONS_B   AD 
WHERE    
       :P_START_ASSET IS NOT NULL                             AND
       :P_END_ASSET IS NULL                                   AND
       AD.ASSET_NUMBER BETWEEN :P_START_ASSET AND AD.ASSET_NUMBER
AND
       AD.ASSET_ID = AD2.ASSET_ID                             AND
       AD.PARENT_ASSET_ID IS NULL                             AND
       AD2.LANGUAGE = userenv('LANG')                         AND
       AH.ASSET_ID    = AD.ASSET_ID                           AND
       AH.DATE_EFFECTIVE    <= SYSDATE                        AND
       NVL(AH.DATE_INEFFECTIVE, SYSDATE+1) > SYSDATE
AND
       AH.CATEGORY_ID = CAT.CATEGORY_ID
AND
       BK.ASSET_ID       =  AD.ASSET_ID                        AND
       BK.BOOK_TYPE_CODE  =  :BOOK                             AND
       BK.DATE_INEFFECTIVE IS NULL             
AND
       LOOKUPS_AT.LOOKUP_CODE = AD.ASSET_TYPE                  AND
       LOOKUPS_AT.LOOKUP_TYPE = 'ASSET TYPE'                   AND
       LOOKUPS_NU.LOOKUP_CODE = AD.NEW_USED                    AND
       LOOKUPS_NU.LOOKUP_TYPE = 'NEWUSE'                       AND
       LOOKUPS_OL.LOOKUP_CODE = AD.OWNED_LEASED                AND
       LOOKUPS_OL.LOOKUP_TYPE = 'OWNLEASE'                     AND
       LOOKUPS_IU.LOOKUP_CODE = AD.IN_USE_FLAG                 AND
       LOOKUPS_IU.LOOKUP_TYPE = 'YESNO'                        AND
       LOOKUPS_PT.LOOKUP_CODE(+) = AD.PROPERTY_TYPE_CODE       AND
       LOOKUPS_PT.LOOKUP_TYPE(+) = 'PROPERTY TYPE'             AND
       LOOKUPS_12.LOOKUP_CODE(+) = AD.PROPERTY_1245_1250_CODE  AND
       LOOKUPS_12.LOOKUP_TYPE(+) = '1245/1250 PROPERTY'
UNION ALL
SELECT 
       AD.ASSET_ID ASSET_ID_MASTER,
       AD.ASSET_NUMBER,
       AD2.DESCRIPTION,
       &CAT_FLEX_ALL_SEG Category_Segments,
       CAT.DESCRIPTION CATEGORY_DESC,
       AD.MANUFACTURER_NAME,
       AD.TAG_NUMBER,
       AD.SERIAL_NUMBER,
       AD.MODEL_NUMBER,
       LOOKUPS_PT.MEANING PROPERTY_TYPE,
       LOOKUPS_12.MEANING PROPERTY_1245_1250,
       LOOKUPS_IU.MEANING IN_USE_FLAG,
       LOOKUPS_OL.MEANING OWNED_LEASED,
       LOOKUPS_NU.MEANING NEW_USED,
       NULL               PARENT_ASSET_NUMBER,
       NULL               PARENT_ASSET_DESC,
       LOOKUPS_AT.MEANING ASSET_TYPE, 
       AD.CURRENT_UNITS
FROM    
       FA_ASSET_HISTORY AH,
       FA_BOOKS         BK,
       FA_CATEGORIES    CAT,
       FA_LOOKUPS       LOOKUPS_AT,
       FA_LOOKUPS       LOOKUPS_NU,
       FA_LOOKUPS       LOOKUPS_OL,
       FA_LOOKUPS       LOOKUPS_IU,
       FA_LOOKUPS       LOOKUPS_PT,
       FA_LOOKUPS       LOOKUPS_12,
       FA_ADDITIONS_TL  AD2,
       FA_ADDITIONS_B   AD 
WHERE    
       :P_START_ASSET IS NULL                                 AND
       :P_END_ASSET IS NULL                                   
AND
       AD.ASSET_ID = AD2.ASSET_ID                             AND
       AD2.LANGUAGE = userenv('LANG')                         AND
       AD.PARENT_ASSET_ID IS NULL                             AND
       AH.ASSET_ID    = AD.ASSET_ID                           AND
       AH.DATE_EFFECTIVE    <= SYSDATE                        AND
       NVL(AH.DATE_INEFFECTIVE, SYSDATE+1) > SYSDATE
AND
       AH.CATEGORY_ID = CAT.CATEGORY_ID
AND
       BK.ASSET_ID       =  AD.ASSET_ID                        AND
       BK.BOOK_TYPE_CODE  =  :BOOK                             AND
       BK.DATE_INEFFECTIVE IS NULL             
AND
       LOOKUPS_AT.LOOKUP_CODE = AD.ASSET_TYPE                  AND
       LOOKUPS_AT.LOOKUP_TYPE = 'ASSET TYPE'                   AND
       LOOKUPS_NU.LOOKUP_CODE = AD.NEW_USED                    AND
       LOOKUPS_NU.LOOKUP_TYPE = 'NEWUSE'                       AND
       LOOKUPS_OL.LOOKUP_CODE = AD.OWNED_LEASED                AND
       LOOKUPS_OL.LOOKUP_TYPE = 'OWNLEASE'                     AND
       LOOKUPS_IU.LOOKUP_CODE = AD.IN_USE_FLAG                 AND
       LOOKUPS_IU.LOOKUP_TYPE = 'YESNO'                        AND
       LOOKUPS_PT.LOOKUP_CODE(+) = AD.PROPERTY_TYPE_CODE       AND
       LOOKUPS_PT.LOOKUP_TYPE(+) = 'PROPERTY TYPE'             AND
       LOOKUPS_12.LOOKUP_CODE(+) = AD.PROPERTY_1245_1250_CODE  AND
       LOOKUPS_12.LOOKUP_TYPE(+) = '1245/1250 PROPERTY'
UNION ALL
SELECT 
       AD.ASSET_ID ASSET_ID_MASTER,
       AD.ASSET_NUMBER,
       AD2.DESCRIPTION,
       &CAT_FLEX_ALL_SEG Category_Segments,
       CAT.DESCRIPTION CATEGORY_DESC,
       AD.MANUFACTURER_NAME,
       AD.TAG_NUMBER,
       AD.SERIAL_NUMBER,
       AD.MODEL_NUMBER,
       LOOKUPS_PT.MEANING PROPERTY_TYPE,
       LOOKUPS_12.MEANING PROPERTY_1245_1250,
       LOOKUPS_IU.MEANING IN_USE_FLAG,
       LOOKUPS_OL.MEANING OWNED_LEASED,
       LOOKUPS_NU.MEANING NEW_USED,
       P_AD.ASSET_NUMBER  PARENT_ASSET_NUMBER,
       P_AD2.DESCRIPTION  PARENT_ASSET_DESC,
       LOOKUPS_AT.MEANING ASSET_TYPE, 
       AD.CURRENT_UNITS
FROM    
       FA_ASSET_HISTORY AH,
       FA_BOOKS         BK,
       FA_CATEGORIES    CAT,
       FA_LOOKUPS       LOOKUPS_AT,
       FA_LOOKUPS       LOOKUPS_NU,
       FA_LOOKUPS       LOOKUPS_OL,
       FA_LOOKUPS       LOOKUPS_IU,
       FA_LOOKUPS       LOOKUPS_PT,
       FA_LOOKUPS       LOOKUPS_12,
       FA_ADDITIONS_TL  P_AD2,
       FA_ADDITIONS_B   P_AD,
       FA_ADDITIONS_TL  AD2,
       FA_ADDITIONS_B   AD
WHERE    
       :P_START_ASSET IS NOT NULL                             AND
       :P_END_ASSET IS NOT NULL                               AND
       AD.ASSET_NUMBER BETWEEN :P_START_ASSET AND :P_END_ASSET
AND
       AD.ASSET_ID = AD2.ASSET_ID                             AND
       AD2.LANGUAGE = userenv('LANG')                         AND
       AD.PARENT_ASSET_ID = P_AD.ASSET_ID                     AND
       P_AD.ASSET_ID = P_AD2.ASSET_ID                         AND
       P_AD2.LANGUAGE = userenv('LANG')                       AND
       AH.ASSET_ID    = AD.ASSET_ID                           AND
       AH.DATE_EFFECTIVE    <= SYSDATE                        AND
       NVL(AH.DATE_INEFFECTIVE, SYSDATE+1) > SYSDATE
AND
       AH.CATEGORY_ID = CAT.CATEGORY_ID
AND
       BK.ASSET_ID       =  AD.ASSET_ID                        AND
       BK.BOOK_TYPE_CODE  =  :BOOK                             AND
       BK.DATE_INEFFECTIVE IS NULL             
AND
       LOOKUPS_AT.LOOKUP_CODE = AD.ASSET_TYPE                  AND
       LOOKUPS_AT.LOOKUP_TYPE = 'ASSET TYPE'                   AND
       LOOKUPS_NU.LOOKUP_CODE = AD.NEW_USED                    AND
       LOOKUPS_NU.LOOKUP_TYPE = 'NEWUSE'                       AND
       LOOKUPS_OL.LOOKUP_CODE = AD.OWNED_LEASED                AND
       LOOKUPS_OL.LOOKUP_TYPE = 'OWNLEASE'                     AND
       LOOKUPS_IU.LOOKUP_CODE = AD.IN_USE_FLAG                 AND
       LOOKUPS_IU.LOOKUP_TYPE = 'YESNO'                        AND
       LOOKUPS_PT.LOOKUP_CODE(+) = AD.PROPERTY_TYPE_CODE       AND
       LOOKUPS_PT.LOOKUP_TYPE(+) = 'PROPERTY TYPE'             AND
       LOOKUPS_12.LOOKUP_CODE(+) = AD.PROPERTY_1245_1250_CODE  AND
       LOOKUPS_12.LOOKUP_TYPE(+) = '1245/1250 PROPERTY'
UNION ALL
SELECT 
       AD.ASSET_ID ASSET_ID_MASTER,
       AD.ASSET_NUMBER,
       AD2.DESCRIPTION,
       &CAT_FLEX_ALL_SEG Category_Segments,
       CAT.DESCRIPTION CATEGORY_DESC,
       AD.MANUFACTURER_NAME,
       AD.TAG_NUMBER,
       AD.SERIAL_NUMBER,
       AD.MODEL_NUMBER,
       LOOKUPS_PT.MEANING PROPERTY_TYPE,
       LOOKUPS_12.MEANING PROPERTY_1245_1250,
       LOOKUPS_IU.MEANING IN_USE_FLAG,
       LOOKUPS_OL.MEANING OWNED_LEASED,
       LOOKUPS_NU.MEANING NEW_USED,
       P_AD.ASSET_NUMBER  PARENT_ASSET_NUMBER,
       P_AD2.DESCRIPTION  PARENT_ASSET_DESC,
       LOOKUPS_AT.MEANING ASSET_TYPE, 
       AD.CURRENT_UNITS
FROM    
       FA_ASSET_HISTORY AH,
       FA_BOOKS         BK,
       FA_CATEGORIES    CAT,
       FA_LOOKUPS       LOOKUPS_AT,
       FA_LOOKUPS       LOOKUPS_NU,
       FA_LOOKUPS       LOOKUPS_OL,
       FA_LOOKUPS       LOOKUPS_IU,
       FA_LOOKUPS       LOOKUPS_PT,
       FA_LOOKUPS       LOOKUPS_12,
       FA_ADDITIONS_TL  P_AD2,
       FA_ADDITIONS_B   P_AD,
       FA_ADDITIONS_TL  AD2,
       FA_ADDITIONS_B   AD 
WHERE    
       :P_START_ASSET IS NULL                                 AND
       :P_END_ASSET IS NOT NULL                               AND
       AD.ASSET_NUMBER BETWEEN AD.ASSET_NUMBER AND :P_END_ASSET
AND
       AD.ASSET_ID = AD2.ASSET_ID                             AND
       AD2.LANGUAGE = userenv('LANG')                         AND
       AD.PARENT_ASSET_ID = P_AD.ASSET_ID                     AND
       P_AD.ASSET_ID = P_AD2.ASSET_ID                         AND
       P_AD2.LANGUAGE = userenv('LANG')                       AND
       AH.ASSET_ID    = AD.ASSET_ID                           AND
       AH.DATE_EFFECTIVE    <= SYSDATE                        AND
       NVL(AH.DATE_INEFFECTIVE, SYSDATE+1) > SYSDATE
AND
       AH.CATEGORY_ID = CAT.CATEGORY_ID
AND
       BK.ASSET_ID       =  AD.ASSET_ID                        AND
       BK.BOOK_TYPE_CODE  =  :BOOK                             AND
       BK.DATE_INEFFECTIVE IS NULL             
AND
       LOOKUPS_AT.LOOKUP_CODE = AD.ASSET_TYPE                  AND
       LOOKUPS_AT.LOOKUP_TYPE = 'ASSET TYPE'                   AND
       LOOKUPS_NU.LOOKUP_CODE = AD.NEW_USED                    AND
       LOOKUPS_NU.LOOKUP_TYPE = 'NEWUSE'                       AND
       LOOKUPS_OL.LOOKUP_CODE = AD.OWNED_LEASED                AND
       LOOKUPS_OL.LOOKUP_TYPE = 'OWNLEASE'                     AND
       LOOKUPS_IU.LOOKUP_CODE = AD.IN_USE_FLAG                 AND
       LOOKUPS_IU.LOOKUP_TYPE = 'YESNO'                        AND
       LOOKUPS_PT.LOOKUP_CODE(+) = AD.PROPERTY_TYPE_CODE       AND
       LOOKUPS_PT.LOOKUP_TYPE(+) = 'PROPERTY TYPE'             AND
       LOOKUPS_12.LOOKUP_CODE(+) = AD.PROPERTY_1245_1250_CODE  AND
       LOOKUPS_12.LOOKUP_TYPE(+) = '1245/1250 PROPERTY'
UNION ALL
SELECT 
       AD.ASSET_ID ASSET_ID_MASTER,
       AD.ASSET_NUMBER,
       AD2.DESCRIPTION,
       &CAT_FLEX_ALL_SEG Category_Segments,
       CAT.DESCRIPTION CATEGORY_DESC,
       AD.MANUFACTURER_NAME,
       AD.TAG_NUMBER,
       AD.SERIAL_NUMBER,
       AD.MODEL_NUMBER,
       LOOKUPS_PT.MEANING PROPERTY_TYPE,
       LOOKUPS_12.MEANING PROPERTY_1245_1250,
       LOOKUPS_IU.MEANING IN_USE_FLAG,
       LOOKUPS_OL.MEANING OWNED_LEASED,
       LOOKUPS_NU.MEANING NEW_USED,
       P_AD.ASSET_NUMBER  PARENT_ASSET_NUMBER,
       P_AD2.DESCRIPTION  PARENT_ASSET_DESC,
       LOOKUPS_AT.MEANING ASSET_TYPE, 
       AD.CURRENT_UNITS
FROM    
       FA_ASSET_HISTORY AH,
       FA_BOOKS         BK,
       FA_CATEGORIES    CAT,
       FA_LOOKUPS       LOOKUPS_AT,
       FA_LOOKUPS       LOOKUPS_NU,
       FA_LOOKUPS       LOOKUPS_OL,
       FA_LOOKUPS       LOOKUPS_IU,
       FA_LOOKUPS       LOOKUPS_PT,
       FA_LOOKUPS       LOOKUPS_12,
       FA_ADDITIONS_TL  P_AD2,
       FA_ADDITIONS_B   P_AD,
       FA_ADDITIONS_TL  AD2,
       FA_ADDITIONS_B   AD 
WHERE    
       :P_START_ASSET IS NOT NULL                             AND
       :P_END_ASSET IS NULL                                   AND
       AD.ASSET_NUMBER BETWEEN :P_START_ASSET AND AD.ASSET_NUMBER
AND
       AD.ASSET_ID = AD2.ASSET_ID                             AND
       AD2.LANGUAGE = userenv('LANG')                         AND
       AD.PARENT_ASSET_ID = P_AD.ASSET_ID                     AND
       P_AD.ASSET_ID = P_AD2.ASSET_ID                         AND
       P_AD2.LANGUAGE = userenv('LANG')                       AND
       AH.ASSET_ID    = AD.ASSET_ID                           AND
       AH.DATE_EFFECTIVE    <= SYSDATE                        AND
       NVL(AH.DATE_INEFFECTIVE, SYSDATE+1) > SYSDATE
AND
       AH.CATEGORY_ID = CAT.CATEGORY_ID
AND
       BK.ASSET_ID       =  AD.ASSET_ID                        AND
       BK.BOOK_TYPE_CODE  =  NVL(:BOOK,BK.BOOK_TYPE_CODE)                           AND
       BK.DATE_INEFFECTIVE IS NULL             
AND
       LOOKUPS_AT.LOOKUP_CODE = AD.ASSET_TYPE                  AND
       LOOKUPS_AT.LOOKUP_TYPE = 'ASSET TYPE'                   AND
       LOOKUPS_NU.LOOKUP_CODE = AD.NEW_USED                    AND
       LOOKUPS_NU.LOOKUP_TYPE = 'NEWUSE'                       AND
       LOOKUPS_OL.LOOKUP_CODE = AD.OWNED_LEASED                AND
       LOOKUPS_OL.LOOKUP_TYPE = 'OWNLEASE'                     AND
       LOOKUPS_IU.LOOKUP_CODE = AD.IN_USE_FLAG                 AND
       LOOKUPS_IU.LOOKUP_TYPE = 'YESNO'                        AND
       LOOKUPS_PT.LOOKUP_CODE(+) = AD.PROPERTY_TYPE_CODE       AND
       LOOKUPS_PT.LOOKUP_TYPE(+) = 'PROPERTY TYPE'             AND
       LOOKUPS_12.LOOKUP_CODE(+) = AD.PROPERTY_1245_1250_CODE  AND
       LOOKUPS_12.LOOKUP_TYPE(+) = '1245/1250 PROPERTY'
UNION ALL
SELECT 
       AD.ASSET_ID ASSET_ID_MASTER,
       AD.ASSET_NUMBER,
       AD2.DESCRIPTION,
       &CAT_FLEX_ALL_SEG Category_Segments,
       CAT.DESCRIPTION CATEGORY_DESC,
       AD.MANUFACTURER_NAME,
       AD.TAG_NUMBER,
       AD.SERIAL_NUMBER,
       AD.MODEL_NUMBER,
       LOOKUPS_PT.MEANING PROPERTY_TYPE,
       LOOKUPS_12.MEANING PROPERTY_1245_1250,
       LOOKUPS_IU.MEANING IN_USE_FLAG,
       LOOKUPS_OL.MEANING OWNED_LEASED,
       LOOKUPS_NU.MEANING NEW_USED,
       P_AD.ASSET_NUMBER  PARENT_ASSET_NUMBER,
       P_AD2.DESCRIPTION  PARENT_ASSET_DESC,
       LOOKUPS_AT.MEANING ASSET_TYPE, 
       AD.CURRENT_UNITS
FROM    
       FA_ASSET_HISTORY AH,
       FA_BOOKS         BK,
       FA_CATEGORIES    CAT,
       FA_LOOKUPS       LOOKUPS_AT,
       FA_LOOKUPS       LOOKUPS_NU,
       FA_LOOKUPS       LOOKUPS_OL,
       FA_LOOKUPS       LOOKUPS_IU,
       FA_LOOKUPS       LOOKUPS_PT,
       FA_LOOKUPS       LOOKUPS_12,
       FA_ADDITIONS_TL  P_AD2,
       FA_ADDITIONS_B   P_AD,
       FA_ADDITIONS_TL  AD2,
       FA_ADDITIONS_B   AD 
WHERE    
       :P_START_ASSET IS NULL                                 AND
       :P_END_ASSET IS NULL                                   
AND
       AD.ASSET_ID = AD2.ASSET_ID                             AND
       AD2.LANGUAGE = userenv('LANG')                         AND
       AD.PARENT_ASSET_ID = P_AD.ASSET_ID                     AND
       P_AD.ASSET_ID = P_AD2.ASSET_ID                         AND
       P_AD2.LANGUAGE = userenv('LANG')                       AND
       AH.ASSET_ID    = AD.ASSET_ID                           AND
       AH.DATE_EFFECTIVE    <= SYSDATE                        AND
       NVL(AH.DATE_INEFFECTIVE, SYSDATE+1) > SYSDATE
AND
       AH.CATEGORY_ID = CAT.CATEGORY_ID
AND
       BK.ASSET_ID       =  AD.ASSET_ID                        AND
       BK.BOOK_TYPE_CODE  =  :BOOK                             AND
       BK.DATE_INEFFECTIVE IS NULL             
AND
       LOOKUPS_AT.LOOKUP_CODE = AD.ASSET_TYPE                  AND
       LOOKUPS_AT.LOOKUP_TYPE = 'ASSET TYPE'                   AND
       LOOKUPS_NU.LOOKUP_CODE = AD.NEW_USED                    AND
       LOOKUPS_NU.LOOKUP_TYPE = 'NEWUSE'                       AND
       LOOKUPS_OL.LOOKUP_CODE = AD.OWNED_LEASED                AND
       LOOKUPS_OL.LOOKUP_TYPE = 'OWNLEASE'                     AND
       LOOKUPS_IU.LOOKUP_CODE = AD.IN_USE_FLAG                 AND
       LOOKUPS_IU.LOOKUP_TYPE = 'YESNO'                        AND
       LOOKUPS_PT.LOOKUP_CODE(+) = AD.PROPERTY_TYPE_CODE       AND
       AH.DATE_EFFECTIVE BETWEEN :P_START_DATE AND :P_END_DATE AND
       LOOKUPS_PT.LOOKUP_TYPE(+) = 'PROPERTY TYPE'             AND
       LOOKUPS_12.LOOKUP_CODE(+) = AD.PROPERTY_1245_1250_CODE  AND
       LOOKUPS_12.LOOKUP_TYPE(+) = '1245/1250 PROPERTY'
ORDER BY 
       2

