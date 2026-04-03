package com.monapp.model;

import jakarta.persistence.*;

@Entity
@Table(name = "etudiant")
public class Etudiant {
    @Id
    @Column(name = "num_etudiant", length = 20)
    private String numEtudiant;

    @Column(name = "nom", nullable = false, length = 200)
    private String nom;

    @Column(name = "prenoms", length = 200)
    private String prenoms;

    @Column(name = "niveau", length = 5)
    private String niveau;

    @Column(name = "adr_email", nullable = false, unique = true, length = 200)
    private String adrEmail;

    // Constructeurs
    public Etudiant() {}

    public Etudiant(String numEtudiant, String nom, String prenoms, String niveau, String adrEmail)
    {
        this.numEtudiant    = numEtudiant;
        this.nom            = nom;
        this.prenoms        = prenoms;
        this.niveau         = niveau;
        this.adrEmail       = adrEmail;
    }

    // Getters et Setters
    public String getNumEtudiant() { return numEtudiant; }
    public void setNumEtudiant(String numEtudiant) { this.numEtudiant = numEtudiant; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getPrenoms() { return prenoms; }
    public void setPrenoms(String prenoms) { this.prenoms = prenoms; }

    public String getNiveau() { return niveau; }
    public void setNiveau(String niveau) { this.niveau = niveau; }

    public String getAdrEmail() { return adrEmail; }
    public void setAdrEmail(String adrEmail) { this.adrEmail = adrEmail; }
}
