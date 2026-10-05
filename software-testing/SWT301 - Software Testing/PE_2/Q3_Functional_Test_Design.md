# Question 3: Functional Test Design

## 3.1 Equivalence Partitioning & Boundary Value Analysis

| Field                   | Valid Partitions                | Invalid Partitions                | Boundary Values                |
|------------------------|----------------------------------|-----------------------------------|-------------------------------|
| Tên quyết định kiểm tra| 30-255 chars, no special/blank, 1st char not number | <30 or >255 chars, special/blank, 1st char is number | 29, 30, 255, 256 chars         |
| Chỉ thị                | 1-10,000 chars                  | >10,000 chars, empty              | 0, 1, 10,000, 10,001 chars    |
| Trưng cầu dân ý        | Selected from list, default 'Chờ'| Not selected                      | -                             |
| Tài liệu kèm theo      | 10-100 chars                    | <10 or >100 chars                 | 9, 10, 100, 101 chars         |
| Tên tài liệu           | 3-10 chars                      | <3 or >10 chars                   | 2, 3, 10, 11 chars            |
| File size              | ≤10MB                           | >10MB                             | 10MB, 10.01MB                 |

---

## 3.2 Integration Test Cases

| TC  | Tên quyết định kiểm tra | Chỉ thị | Trưng cầu dân ý | Tài liệu kèm theo | Tên tài liệu | File size | Expected Result |
|-----|-------------------------|---------|-----------------|-------------------|--------------|-----------|-----------------|
| TC1 | 30 chars, valid         | valid   | Chờ             | 10 chars, valid   | 3 chars      | 10MB      | Pass            |
| TC2 | 255 chars, valid        | valid   | Option2         | 100 chars, valid  | 10 chars     | 1MB       | Pass            |
| TC3 | 29 chars                | valid   | Chờ             | 10 chars, valid   | 3 chars      | 10MB      | Fail            |
| TC4 | 256 chars               | valid   | Chờ             | 10 chars, valid   | 3 chars      | 10MB      | Fail            |
| TC5 | valid                   | >10,000 | Chờ             | 10 chars, valid   | 3 chars      | 10MB      | Fail            |
| TC6 | valid                   | valid   | (not selected)  | 10 chars, valid   | 3 chars      | 10MB      | Fail            |
| TC7 | valid                   | valid   | Chờ             | 9 chars           | 3 chars      | 10MB      | Fail            |
| TC8 | valid                   | valid   | Chờ             | 10 chars, valid   | 2 chars      | 10MB      | Fail            |
| TC9 | valid                   | valid   | Chờ             | 10 chars, valid   | 3 chars      | 10.01MB   | Fail            |
| TC10| valid, 1st char number  | valid   | Chờ             | 10 chars, valid   | 3 chars      | 10MB      | Fail            |

---

## 3.3 Detailed Pre-condition and Test Case Procedure

| TC  | Pre-condition | Test Case Procedure |
|-----|--------------|---------------------|
| TC1 | All fields empty | 1. Enter valid data for all fields at lower boundary. 2. Click 'Lưu'. 3. Expect success. |
| TC2 | All fields empty | 1. Enter valid data for all fields at upper boundary. 2. Click 'Lưu'. 3. Expect success. |
| TC3 | All fields empty | 1. Enter 29 chars for 'Tên quyết định kiểm tra'. 2. Fill other fields valid. 3. Click 'Lưu'. 4. Expect error. |
| TC4 | All fields empty | 1. Enter 256 chars for 'Tên quyết định kiểm tra'. 2. Fill other fields valid. 3. Click 'Lưu'. 4. Expect error. |
| TC5 | All fields empty | 1. Enter >10,000 chars for 'Chỉ thị'. 2. Fill other fields valid. 3. Click 'Lưu'. 4. Expect error. |
| TC6 | All fields empty | 1. Leave 'Trưng cầu dân ý' unselected. 2. Fill other fields valid. 3. Click 'Lưu'. 4. Expect error. |
| TC7 | All fields empty | 1. Enter 9 chars for 'Tài liệu kèm theo'. 2. Fill other fields valid. 3. Click 'Lưu'. 4. Expect error. |
| TC8 | All fields empty | 1. Enter 2 chars for 'Tên tài liệu'. 2. Fill other fields valid. 3. Click 'Lưu'. 4. Expect error. |
| TC9 | All fields empty | 1. Attach file >10MB. 2. Fill other fields valid. 3. Click 'Lưu'. 4. Expect error. |
| TC10| All fields empty | 1. Enter 'Tên quyết định kiểm tra' starting with number. 2. Fill other fields valid. 3. Click 'Lưu'. 4. Expect error. | 