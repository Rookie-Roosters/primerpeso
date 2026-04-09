CREATE UNIQUE INDEX expenses_user_receipt_unique_idx
    ON expenses (user_id, receipt_id)
    WHERE receipt_id IS NOT NULL;
