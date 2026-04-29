package com.monapp.model;

import java.time.LocalDateTime;

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
    private String email;
    
    @Column(name = "mdp_etudiant", length = 255)
    private String password;

    @Column(name = "approuveEtu")
    private boolean approuve = false;

    @Column(name = "date_inscritEtu", updatable = false)
    private LocalDateTime dateInscrit;

    @PrePersist
    protected void onCreate(){
        this.dateInscrit = LocalDateTime.now();
    }
    
    // Constructeur vide — OBLIGATOIRE pour JPA
    public Etudiant() {}

    // Constructeur complet — utilisé dans la Servlet
    public Etudiant(String numEtudiant, String nom, String prenoms, String niveau, String email, String password)
    {
        this.numEtudiant    = numEtudiant;
        this.nom            = nom;
        this.prenoms        = prenoms;
        this.niveau         = niveau;
        this.email          = email;
        this.password       = password;
    }

    // Getters et Setters
    public String getNumEtudiant() { return numEtudiant; } // Lire la valeur
    public void setNumEtudiant(String numEtudiant) { this.numEtudiant = numEtudiant; } // Modifier la valeur

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getPrenoms() { return prenoms; }
    public void setPrenoms(String prenoms) { this.prenoms = prenoms; }

    public String getNiveau() { return niveau; }
    public void setNiveau(String niveau) { this.niveau = niveau; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public boolean isApprouve() { return approuve; }
    public void setApprouve(boolean approuve) { this.approuve = approuve; }

    public LocalDateTime getDateInscrit() { return dateInscrit; }
    public void setDateInscrit(LocalDateTime dateInscrit){ this.dateInscrit = dateInscrit; }
}
