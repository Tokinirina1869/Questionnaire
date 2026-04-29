package com.monapp.model;

import java.time.LocalDateTime;
import jakarta.persistence.*;

@Entity
@Table(name = "administrateur") // On précise le nom de la table SQL
public class Admin {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_admin")
    private Long idAdmin;

    @Column(name = "nom_admin", nullable = false, length = 100)
    private String nomAdmin;

    @Column(name = "email_admin", nullable = false, unique = true, length = 200)
    private String emailAdmin;

    @Column(name = "mdp_admin", length = 255)
    private String mdpAdmin;

    @Column(name = "approuve")
    private boolean approuve = false;

    @Column(name = "date_inscrit", updatable = false)
    private LocalDateTime dateInscrit;

    @PrePersist
    protected void onCreate(){
        this.dateInscrit = LocalDateTime.now();
    }

    public Admin() {}

    // Getters et Setters
    public Long getIdAdmin() { return idAdmin; }
    public void setIdAdmin(Long idAdmin) { this.idAdmin = idAdmin; }

    public String getNomAdmin() { return nomAdmin; }
    public void setNomAdmin(String nomAdmin) { this.nomAdmin = nomAdmin; }

    public String getEmailAdmin() { return emailAdmin; }
    public void setEmailAdmin(String emailAdmin) { this.emailAdmin= emailAdmin; }

    public String getMdpAdmin() { return mdpAdmin; }
    public void setMdpAdmin(String mdpAdmin) { this.mdpAdmin = mdpAdmin; }

    public boolean isApprouve() { return approuve; }
    public void setApprouve(boolean approuve) { this.approuve = approuve; }

    public LocalDateTime getDateInscrit() { return dateInscrit; }
    public void setDateInscrit(LocalDateTime dateInscrit){ this.dateInscrit = dateInscrit; }
}