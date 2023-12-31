CREATE TABLE patients(
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE medical_histories(
    id INT NOT NULL AUTO_INCREMENT,
    admitted_at DATETIME NOT NULL,
    patient_id INT NOT NULL,
    status VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (patient_id) REFERENCES patients(id)
);

CREATE TABLE treatments(
    id INT NOT NULL AUTO_INCREMENT,
    type VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
);

-- join table for medical_histories and treatments
CREATE TABLE medical_histories_treatments(
    medical_history_id INT NOT NULL,
    treatment_id INT NOT NULL,
    PRIMARY KEY (medical_history_id, treatment_id),
    FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
    FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

CREATE INDEX idx_treatment_history ON medical_histories_treatments (medical_history_id,treatment_id);

CREATE TABLE invoices(
    id INT NOT NULL AUTO_INCREMENT,
    total_amount DECIMAL(10,2) NOT NULL,
    generated_at DATETIME NOT NULL,
    payed_at DATETIME,
    medical_history_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);

CREATE INDEX idx_invoice_medical_history_id ON invoices(medical_history_id);

CREATE TABLE invoice_items(
    id INT NOT NULL AUTO_INCREMENT,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    invoice_id INT NOT NULL,
    treatment_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (invoice_id) REFERENCES invoices(id),
    FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

CREATE INDEX idx_invoice_item_invoice ON invoice_items(invoice_id,treatment_id);
