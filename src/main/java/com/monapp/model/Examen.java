package com.monapp.model;

import jakarta.persistence.*;

@Entity
@Table(name = "examen")
public class Examen {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "num_exam")
    private Integer numExam;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "num_etudiant")
    private Etudiant etudiant;

    @Column(name = "annee_univ", length = 9, nullable = false)
    private String anneeUniv;

    @Column(name = "note")
    private int note;


    public Examen() {}

    public Examen(Etudiant etudiant, String anneeUniv, Integer note)
    {
        this.etudiant   = etudiant;
        this.anneeUniv  = anneeUniv;
        this.note       = note;
    }

    public Integer getNumExam() { return numExam; }
    public void setNumExam(Integer numExam) { this.numExam = numExam; }

    public Etudiant getEtudiant() { return etudiant; }
    public void setEtudiant(Etudiant etudiant) { this.etudiant = etudiant; }

    public String getAnneeUniv(){ return anneeUniv; }
    public void setAnneeUniv(String anneeUniv) { this.anneeUniv = anneeUniv; }

    public Integer getNote() { return note; }
    public void setNote(Integer note) { this.note = note; }
}
