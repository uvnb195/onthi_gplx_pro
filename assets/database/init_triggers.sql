CREATE UNIQUE INDEX IF NOT EXISTS idx_lp_license_total
	ON learning_progress (user_id, license_id)
	WHERE question_category_id IS NULL;
-- end
CREATE UNIQUE INDEX IF NOT EXISTS idx_lp_category_detail 
	ON learning_progress (user_id, license_id, question_category_id) 
	WHERE question_category_id IS NOT NULL;
-- end
CREATE TRIGGER IF NOT EXISTS trg_init_qs_status
after insert on question_status
for each row
when NEW.option_id is not null
begin
	update question_status 
	set
		is_new = 1
	where question_id = NEW.question_id;
end;
-- end
create trigger IF NOT EXISTS trg_update_qs_status
after update of option_id on question_status
for each row
WHEN OLD.option_id IS NOT NULL AND OLD.is_new = 1
begin
	UPDATE question_status 
    SET is_new = 0
    WHERE question_id = NEW.question_id;
end;
-- end
CREATE TRIGGER IF NOT EXISTS trg_upsert_lp_total
after update of option_id on question_status
for each row
when new.option_id is not null and new.is_correct is not null
BEGIN
  insert into learning_progress(
    user_id,
    license_id,
    question_category_id,
    total_questions,
    answered_questions,
    correct_answers,
    total_attempts,
    correct_attempts,
    updated_at
  )
  select 
    new.user_id,
    u.license_id,
    null,
    (SELECT COUNT(*) FROM license_question WHERE license_id = u.license_id),
    1, -- init answered_questions
    ifnull(NEW.is_correct,0), -- init correct_answers
    1,
    ifnull(NEW.is_correct,0), -- init correct_attempts
    STRFTIME('%Y-%m-%d %H:%M:%S', 'now')
    
  from 
    user_table u
  JOIN question q ON q.id = NEW.question_id 
  WHERE u.id = NEW.user_id
  
  ON CONFLICT(user_id, license_id) 
  WHERE question_category_id IS NULL DO UPDATE SET
   correct_answers = correct_answers + 
      (CASE WHEN (OLD.is_correct IS NULL OR OLD.is_correct = 0) AND NEW.is_correct = 1 THEN 1 
      when old.is_correct = 1 and new.is_correct = 0 then -1
      ELSE 0 END),
    total_attempts = total_attempts + 1,
    correct_attempts = correct_attempts + NEW.is_correct,
    updated_at = STRFTIME('%Y-%m-%d %H:%M:%S', 'now');
  END;
-- end

CREATE TRIGGER IF NOT EXISTS trg_upsert_lp_total_when_question_status_is_new
after update of is_new on question_status
for each row
when new.is_new is not null and new.is_new = 1
BEGIN
  insert into learning_progress(
    user_id,
    license_id,
    question_category_id,
    total_questions,
    answered_questions,
    correct_answers,
    total_attempts,
    correct_attempts,
    updated_at
  )
  select 
    new.user_id,
    u.license_id,
    null,
    (SELECT COUNT(*) FROM license_question WHERE license_id = u.license_id),
    1, -- init answered_questions
    ifnull(NEW.is_correct,0), -- init correct_answers
    1,
    ifnull(NEW.is_correct,0), -- init correct_attempts
    STRFTIME('%Y-%m-%d %H:%M:%S', 'now')
    
  from 
    user_table u
  JOIN question q ON q.id = NEW.question_id 
  WHERE u.id = NEW.user_id
  
  ON CONFLICT(user_id, license_id) 
  WHERE question_category_id IS NULL DO UPDATE SET
    answered_questions = answered_questions + 1,
   correct_answers = correct_answers + ifnull(new.is_correct,0),
    total_attempts = total_attempts + 1,
    correct_attempts = correct_attempts + ifnull(NEW.is_correct,0),
    updated_at = STRFTIME('%Y-%m-%d %H:%M:%S', 'now');
  END;

-- end

CREATE TRIGGER IF NOT EXISTS trg_upsert_lp_by_category
after update of option_id on question_status
for each row
when new.option_id is not null and new.is_correct is not null
BEGIN
  insert into learning_progress(
    user_id,
    license_id,
    question_category_id,
    total_questions,
    answered_questions,
    correct_answers,
    total_attempts,
    correct_attempts,
    updated_at
  )
  select 
    new.user_id,
    u.license_id,
    q.category_id,
    (SELECT COUNT(*) FROM question q_inner JOIN license_question lq_inner ON q_inner.id = lq_inner.question_id
      WHERE 
        lq_inner.license_id = u.license_id
        AND 
        q_inner.category_id = q.category_id
    ),
    1, -- init answered_questions
    ifnull(NEW.is_correct,0), -- init correct_answers
    1,
    ifnull(NEW.is_correct,0), -- init correct_attempts
    STRFTIME('%Y-%m-%d %H:%M:%S', 'now')
    
  from 
    user_table u
  JOIN question q ON q.id = NEW.question_id 
  WHERE u.id = NEW.user_id
  
  ON CONFLICT(user_id, license_id, question_category_id)
  WHERE question_category_id IS NOT NULL DO UPDATE SET
   correct_answers = correct_answers + 
      (CASE WHEN (OLD.is_correct IS NULL OR OLD.is_correct = 0) AND NEW.is_correct = 1 THEN 1 
      when old.is_correct = 1 and new.is_correct = 0 then -1
      ELSE 0 END),
    total_attempts = total_attempts + 1,
    correct_attempts = correct_attempts + NEW.is_correct,
    updated_at = STRFTIME('%Y-%m-%d %H:%M:%S', 'now');
  END;
-- end

CREATE TRIGGER IF NOT EXISTS trg_upsert_lp_by_category_when_question_status_is_new
after update of is_new on question_status
for each row
when new.is_new is not null and new.is_new = 1
BEGIN
  insert into learning_progress(
    user_id,
    license_id,
    question_category_id,
    total_questions,
    answered_questions,
    correct_answers,
    total_attempts,
    correct_attempts,
    updated_at
  )
  select 
    new.user_id,
    u.license_id,
    q.category_id,
    (SELECT COUNT(*) FROM question q_inner JOIN license_question lq_inner ON q_inner.id = lq_inner.question_id
      WHERE 
        lq_inner.license_id = u.license_id
        AND 
        q_inner.category_id = q.category_id
    ),
    1, -- init answered_questions
    ifnull(NEW.is_correct,0), -- init correct_answers
    1,
    ifnull(NEW.is_correct,0), -- init correct_attempts
    STRFTIME('%Y-%m-%d %H:%M:%S', 'now')
    
  from 
    user_table u
  JOIN question q ON q.id = NEW.question_id 
  WHERE u.id = NEW.user_id
  
 ON CONFLICT(user_id, license_id, question_category_id)
  WHERE question_category_id IS NOT NULL DO UPDATE SET
    answered_questions = answered_questions + 1,
   correct_answers = correct_answers + ifnull(new.is_correct,0),
    total_attempts = total_attempts + 1,
    correct_attempts = correct_attempts + ifnull(NEW.is_correct,0),
    updated_at = STRFTIME('%Y-%m-%d %H:%M:%S', 'now');
  END;


