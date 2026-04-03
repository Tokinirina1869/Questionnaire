package com.monapp.service;

import com.monapp.model.Etudiant;
import com.monapp.repository.EtudiantRepository;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;
import java.util.List;

@Stateless
public class EtudiantService {
    @Inject
    private EtudiantRepository repo;

    public void ajouter(Etudiant e)
    {
        repo.save(e);
    }

    public List<Etudiant> lister()
    {
        return repo.findAll();
    }

    public void supprimer(Etudiant e) 
    {
        repo.delete(e);
    }

    public Etudiant rechercherParNum(String numEtudiant)
    {
        return repo.find(numEtudiant);
    }
}
