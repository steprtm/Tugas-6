use bisnis;

CREATE TABLE Perusahaan (
  id_p VARCHAR(255) PRIMARY KEY,
  nama VARCHAR(255),
  alamat VARCHAR(255)
);

CREATE TABLE Projek (
  id_proj VARCHAR(255) PRIMARY KEY,
  nama VARCHAR(255),
  tgl_mulai DATE,
  tgl_selesai DATE,
  status VARCHAR(255)
);

CREATE TABLE Manajer (
  manajer_nik VARCHAR(255) PRIMARY KEY,
  nama VARCHAR(255),
  id_dept VARCHAR(255),
  sup_nik VARCHAR(255)
);

CREATE TABLE Departemen (
  id_dept VARCHAR(255) PRIMARY KEY,
  nama VARCHAR(255),
  id_p VARCHAR(255),
  manajer_nik VARCHAR(255),
  FOREIGN KEY (id_p) REFERENCES Perusahaan(id_p),
  FOREIGN KEY (manajer_nik) REFERENCES Manajer(manajer_nik)
);
ALTER TABLE Manajer
ADD FOREIGN KEY (id_dept) REFERENCES Departemen(id_dept);

CREATE TABLE Penugasan (
  id_proj VARCHAR(255),
  manajer_nik VARCHAR(255),
  FOREIGN KEY (id_proj) REFERENCES Projek(id_proj),
  FOREIGN KEY (manajer_nik) REFERENCES Manajer(manajer_nik)
);

INSERT INTO Penugasan (id_proj, manajer_nik)
VALUES
('PJ01', 'N01'),
('PJ01', 'N02'),
('PJ01', 'N03'),
('PJ01', 'N04'),
('PJ01', 'N05'),
('PJ01', 'N07'),
('PJ01', 'N08'),
('PJ02', 'N01'),
('PJ02', 'N03'),
('PJ02', 'N05'),
('PJ03', 'N03'),
('PJ03', 'N07'),
('PJ03', 'N08');


SELECT DISTINCT d.nama AS nama_departemen
FROM Departemen d
LEFT JOIN Manajer m ON d.id_dept = m.id_dept
LEFT JOIN Penugasan pn ON m.manajer_nik = pn.manajer_nik
LEFT JOIN Projek p ON pn.id_proj = p.id_proj;


SELECT p.id_proj, p.nama AS nama_projek, COUNT(DISTINCT m.manajer_nik) AS jumlah_karyawan
FROM Projek p
JOIN Penugasan pn ON p.id_proj = pn.id_proj
JOIN Manajer m ON pn.manajer_nik = m.manajer_nik
GROUP BY p.id_proj, p.nama;


SELECT COUNT(*) AS jumlah_projek
FROM Projek p
JOIN Penugasan pn ON p.id_proj = pn.id_proj
JOIN manajer k ON pn.manajer_nik = k.manajer_nik
JOIN Departemen d ON k.id_dept = d.id_dept
WHERE d.nama = 'RnD' AND p.status = 1;

SELECT COUNT(*) AS jumlah_projek
FROM Projek p
JOIN Penugasan pn ON p.id_proj = pn.id_proj
JOIN Manajer m ON pn.manajer_nik = m.manajer_nik
WHERE m.nama = 'Ari';

SELECT m.nama AS nama_karyawan
FROM manajer m
JOIN Penugasan pn ON m.manajer_nik = pn.manajer_nik
JOIN Projek p ON pn.id_proj = p.id_proj
WHERE p.nama = 'B';
