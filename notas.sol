pragma solidity >=0.4.4 < 0.7.0;
pragma experimental ABIEncoderV2;

contract Notas{
    //Direccion del profesor
    address public profesor;

    //Mapping que relaciona el id
    mapping(bytes32=>uint) _Notas;

    //Array de alumnos
    string[] revisiones;

    //Constructor
    constructor()public{
        profesor = msg.sender;

    }
    
    //Eventos
    event alumnoEvaluado(bytes32);
    event eventoRevision(string);

    modifier unicamenteProfesor(address direccion){
        require(direccion == profesor);
        _;
    }

    function evaluar(string memory _idAlumno,uint _nota)public unicamenteProfesor(msg.sender){
        bytes32 hashIdAlumno = keccak256(abi.encodePacked(_idAlumno));
        _Notas[hashIdAlumno] = _nota;
        emit alumnoEvaluado(hashIdAlumno);
        
    }

    function verNotas(string memory _idAlumno)public view returns(uint){
        bytes32 hashIdAlumno = keccak256(abi.encodePacked(_idAlumno));
        return _Notas[hashIdAlumno];
    }

    function revision(string memory _idAlumno)public{
        revisiones.push(_idAlumno);
        emit eventoRevision(_idAlumno);
    }
    
    function verRevisiones()public view unicamenteProfesor(msg.sender) returns(string[] memory){
        return revisiones;
    }

}