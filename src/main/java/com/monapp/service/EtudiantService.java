package com.monapp.service;

import com.monapp.model.Etudiant;
import com.monapp.repository.EtudiantRepository;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;

@Stateless
public class EtudiantService {
    @Inject
    private EtudiantRepository repo;

    public void ajouter(Etudiant e) throws Exception
    {
        String mdpClair = e.getPassword();

        String mdpHash = BCrypt.hashpw(mdpClair, BCrypt.gensalt());

        e.setPassword(mdpHash);

        repo.save(e);
    }

    public List<Etudiant> lister()
    {
        return repo.findAll();
    }

    public void modifier(Etudiant e)
    {
        repo.update(e);
    }
    
    public void supprimer(Etudiant e) 
    {
        repo.delete(e);
    }

    public Etudiant rechercherParNum(String numEtudiant)
    {
        return repo.find(numEtudiant);
    }

    public List<Etudiant> rechercher(String query)
    {
        if (query == null || query.trim().isEmpty()) {
            return repo.findAll();
        }
        
        return repo.search(query);
    }

    public String generateProchainNum()
    {
        return repo.generateProchainNum();
    }

    public Long countEtudiant()
    {
       return repo.countEtudiant();
    }

    public void approuverEtudiant(String num){
        if (num != null) {
            repo.validerAcces(num);
            System.out.println("Étudiant " + num + " approuvé avec succès.");
        }
    }

    public void rejeterEtudiant(String num){
        if (num != null) {
            repo.rejeterAcces(num);
            System.out.println("Étudiant " + num + " approuvé avec succès.");
        }
    }
       
}
