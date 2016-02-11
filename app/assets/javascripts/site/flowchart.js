$(document).ready(function(){
  if ($("#flowchart").length == 0)  return;

  $.each(flowInfo, function(key, value) {
    var id = "#" + key;
    var self = $("svg "+id);
    self.attr('data-content', value);

    self.popover({
      'trigger':'hover click'
      ,'container': 'body'
      ,'placement': 'auto'
      ,'white-space': 'nowrap'
      ,'html':'true'
      ,'delay': {show: 50, hide: 400}
    });

  });
});

/*
 * Fixed popover leave
 * From: http://jsfiddle.net/WojtekKruszewski/Zf3m7/22/
 */
var originalLeave = $.fn.popover.Constructor.prototype.leave;
$.fn.popover.Constructor.prototype.leave = function(obj){
  var self = obj instanceof this.constructor ?
    obj : $(obj.currentTarget)[this.type](this.getDelegateOptions()).data('bs.' + this.type)
  var container, timeout;

  originalLeave.call(this, obj);

  if(obj.currentTarget) {
    //container = $(obj.currentTarget).siblings('.popover')
    container = $('.popover');
    timeout = self.timeout;
    container.one('mouseenter', function(){
      //We entered the actual popover – call off the dogs
      clearTimeout(timeout);
      //Let's monitor popover content instead
      container.one('mouseleave', function(){
        $.fn.popover.Constructor.prototype.leave.call(self, self);
      });
    })
  }
};

var popover_data = `{
"rect2985-2-0" : "
    <strong>Etapa 1:</strong> O acadêmico deve assistir a palestra sobre o TCC
    em data e horário determinado pelo professor responsável. Além disso, deve
    ler o <a target='_blank' href='https://drive.google.com/file/d/0B2_vcPBwSN6CTGlLd3pLay1BRHM/view?usp=sharing'>
    Regulamento de TCC da UTFPR</a> e as <a target='_blank'
    href='https://drive.google.com/file/d/0B2_vcPBwSN6CMmlMZk9YckE5MFE/view?usp=sharing'>
    Normas Operacionais Complementares do TCC para o Curso de TSI</a>."

,"g3834-0-65" : "
    <strong>Etapa 2:</strong> O acadêmico de TSI deve frequentar a disciplina
    de Metodologia Ciêntifica."

,"g5905": "
   <strong>Etapa 3:</strong>
   O acadêmico deve procurar os professores de TSI para conhecer suas linhas de
   pesquisas, projetos, áreas de interesse, etc. Isso com o propósito de
   encontrar o orientador e tema para o seu TCC."

,"g3834-0-6-5": "
   <strong>Etapa 4:</strong>
   O acadêmico deve se matricular, via sistema acadêmico, na disciplina de TCC 1."

,"g3834-0-6-5-5" : "
   <strong>Etapa 5:</strong>
     <p>Entregar ao professor da disciplina de TCC 1:</p>
     <ul>
       <li>
         <a href='https://drive.google.com/file/d/0B2_vcPBwSN6CRWtxaGphSDNyQzg/view?usp=sharing target=_blank'>
           Termo de Compromisso de Orienta&ccedil;&atilde;o de TCC</a>;
       </li>
       <li>
         Comprovante de aprova&ccedil;&atilde;o ou de estar cursando a disciplina de Metodologia de Pesquisa;
       </li>
       <li>
        Caso o TCC seja realizado em um empresa, o acadêmico deve também entregar o
           <a href='https://drive.google.com/file/d/0B2_vcPBwSN6CVDNzWmRuRDNRa2M/view?usp=sharing' target='_blank' >Termo de Realização de TCC em Empresa.</a>
       </li>
     </ul>"

,"g5973":"
     <strong>Etapa 6:</strong>
     <p>Nesta etapa o acadêmico deve:</p>
     <ul>
       <li>
         Desenvolver a escrita da Proposta de TCC conforme o 
         <a href='https://drive.google.com/file/d/0B2_vcPBwSN6Cb0xCT3JaTVZKZzA/view?usp=sharing' target='_blank'>
         Modelo de Proposta de TCC 1</a> e
         indicações do professor da disciplina de TCC 1.
       </li>
       <li>
           Registrar no sistema do TCC todas as reuniões com seu orientador, o mínimo de reuniões por semestre é 4,
           casam sejam feitas menos de 4 reuniões, o acadêmico não poderá realizar a defesa do TCC.
       </li>
     </ul>"

,"g6462" : "
     <strong>Etapa 7:</strong>
     <p>Entregar a proposta para professor orientador corrigir, atente-se para que
     ele tenha tempo hábil para correção antes da entrega para avaliação.</p> "

,"g11645" : "
     <strong>Etapa 8:</strong>
     <p>Nesta etapa o acadêmico deve:</p>
     <ul>
       <li>
          Entregar a proposta de TCC digital no sistema do TCC e encadernada ao professor de
          TCC 1, para que seja encaminhado para avaliação dos professores que
          participarão da banca de defesa de proposta.
       </li>
       <li>
          Acompanhado do projeto, o acadêmico deve entregar a 
          <a target='_blank' href='https://drive.google.com/file/d/0B2_vcPBwSN6CM2dyY1RoLXJhazA/view?usp=sharing'>
          Ficha de Autorização para Realização da Defesa de TCC</a> assinada pelo seu orientador.
       </li>
     </ul>"

,"g3834-0-6-5-9-8-8-4" : "
     <strong>Etapa 9:</strong>
     <p>Realizar a prévia da defesa da proposta com o professor orientador.</p>"

,"g10110": "
     <strong>Etapa 10:</strong>
     <p>
       O acadêmico deve realizar uma apresentação de no máximo 15 minutos para
       defender sua proposta de TCC. Esta será avaliada por uma banca composta de 3
       professores.
     </p>
   "
,"g10084": "
     <strong>Etapa 11:</strong>
     <p>
       O acadêmico deve realizar a correção da sua proposta de TCC de acordo com as
       indicações da banca, estas devem ser avaliadas e validadas pelo seu orientador.
     </p>
   "

,"g3834-0-6-5-9-8-8-4-6-8-5": "
     <strong>Etapa 12:</strong>
     <p>
       O acadêmico deve entregar, via sistema do TCC, a versão corrigida da sua
       proposta de TCC.
     </p>
   "

,"g9056": "
     <strong>Etapa 13:</strong>
     <p>
       Desenvolver o projeto de TCC. Para isso, o acadêmico deve manter
       reuniões semanais, devidamente registradas no sistema do TCC, com seu orientador.
       Além disso, seguir as recomendações do professor da disciplina de TCC 1.
     </p>
   "

,"rect2985-9-6-2-8-9-6-1-1-0-7-5-9": "
     <strong>Etapa 14:</strong>
     <p>
       O acadêmico deve entregar para o seu
       orientador o projeto de TCC para correção, de acordo
       com o <a href='https://drive.google.com/file/d/0B2_vcPBwSN6CRkN6aHV3MDlaNlU/view?usp=sharing' target='_blank'>Modelo de Projeto de TCC</a>.
       Atente-se para que ele tenha tempo hábil para correção antes da entrega para avaliação.
     </p>
   "
,"rect2985-9-6-2-8-9-6-1-1-0-7-5-9-0": "
     <strong>Etapa 15:</strong>
     <p>Nesta etapa o acadêmico deve:</p>
     <ul>
       <li>
          O acadêmico deve entregar projeto de TCC, encadernado, ao professor
          de TCC 1, para que seja encaminhada para avaliação dos professores
          que participarão da banca de defesa de projeto de TCC.
       </li>
       <li>
          Acompanhado do projeto, o acadêmico deve entregar a 
          <a target='_blank' href='https://drive.google.com/file/d/0B2_vcPBwSN6CM2dyY1RoLXJhazA/view?usp=sharing'>
          Ficha de Autorização para Realização da Defesa de TCC</a> assinada pelo seu orientador.
       </li>
       <li>
          Para que o acadêmico possa realizar a defesa, todas reuniões devem estar registradas
          no sistema do TCC.
       </li>
     </ul>
   "

,"g6502": "
     <strong>Etapa 16:</strong>
     <p>
       O acadêmico deve apresentar um prévia de sua defesa para o professor orientador.
     </p>
   "

,"g3834-0-6-5-9-8-8-4-6-6-6": "
     <strong>Etapa 17:</strong>
     <p>
       O acadêmico deve realizar uma apresentação de no máximo 15 minutos para
       defender o desenvolvimento de seu projeto. Esta apresentação assim
       como o texto escrito, será avaliado por uma banca composta de 3
       professores.
     </p>
   "

,"g10353": "
     <strong>Etapa 18:</strong>
     <p>
       O acadêmico deve realizar a correção do seu projeto de acordo com as
       indicações da banca avaliadora. Estas devem ser avaliadas e validadas
       por seu orientador.
     </p>
   "

,"g3834-0-6-5-9-8-8-4-6-8-5-2-7-8-5": "
     <strong>Etapa 19:</strong>
     <p>Nesta etapa o acadêmico deve:</p>
     <ul>
       <li>
         Entregar, via sistema do TCC, a versão corrigida do seu projeto.
       </li>
     </ul>
   "

,"g3834-0-6-5-0": "
     <strong>Etapa 20:</strong>
     <p>
       O  acadêmico aprovado em TCC 1, deverá solicitar sua mátricula em TCC
       2 ao professor responsável via protocolo, no prazo de 50
       (cinquenta) dias antes do final do semestre, devendo continuar com
       o mesmo orientador.
     </p>
   "

,"g3834-0-6-5-9-8-8-4-6-8-5-2-6": "
     <strong>Etapa 21:</strong>
     <p>Nesta etapa o acadêmico deve:</p>
     <ul>
       <li>
        Realizar o desenvolvimento do seu TCC. 
       </li>
       <li>
         Manter pelo menos um reuniões semanais, devidamente
         registrada no sistema do TCC, com o seu orientador.
       </li>
     </ul>
   "
,"g3834-0-6-5-9-8-8-4-6-8-4":"
       <strong>Etapa 22:</strong>
       <p>Desenvolver a escrita do projeto de TCC conforme o 
       <a target='_blank' href='https://drive.google.com/file/d/0B2_vcPBwSN6CaVdPSTkwb2tjbzQ/view?usp=sharing'>Modelo de
       Monografia de TCC 2</a>.</p>"

,"g5230" : "
     <strong>Etapa 23:</strong>
     <p>
       O acadêmico deve entregar para o seu
       orientador a monografia de TCC para correção.
       Atente-se para que ele tenha tempo hábil para correção antes da entrega para avaliação.
     </p>"

,"g3834-0-6-5-9-8-7-0":"
     <strong>Etapa 24:</strong>
     <p>Nesta etapa o acadêmico deve:</p>
     <ul>
       <li>
         O acadêmico deve entregar 3 cópias encadernadas da monografia final
         ao professor responsável pelo TCC, para que seja encaminhada para
         avaliação dos professores que participarão da banca de TCC 2.
       </li>
       <li>
         Acompanhado da monografia, o acadêmico deve entregar a <a
           href='https://drive.google.com/file/d/0B2_vcPBwSN6CTXB5ZC1NdWluRTg/view?usp=sharing' target='_blank'>Ficha
           de Encaminhamento de TCC para Banca Avaliadora</a> assinada pelo
           seu orientador.
       </li>
       <li>
         Adicionalmente, todas reuniões devem estar devidamente registradas no sistema
         do TCC, caso existam menos que 4 reuniões registradas, o acadêmico não poderá defender seu TCC.
       </li>
     </ul>
    "

,"g3834-0-6-5-9-8-8-4-6-0":"
      <strong>Etapa 25:</strong>
      <p>O acadêmico deve apresentar um prévia de sua defesa o professor
         orientador.</p>
    "

,"g3834-0-6-5-9-8-8-4-6-0-7":"
   <strong>Etapa 26:</strong>
   <p>O acadêmico deve realizar uma apresentação de no máximo 20 minutos para
     defender o seu trabalho de TCC. Esta apresentação, assim como a
     monografia, será avaliado por uma banca composta de 3 professores.</p>" 

,"g3834-0-6-5-9-8-8-4-6-8-5-2-6-6":"
   <strong>Etapa 27:</strong>
   <p>Nesta etapa o acadêmico deve:</p>
     <ul>
       <li>
         O acadêmico deve realizar a correção da monografia de acordo com os
         apontamentos da banca.
       </li>
       <li>
         Avaliar e validar as alterações com seu orientador.
       </li>
       <li>
         Nesse ponto o acadêmico deve verificar, de acordo com sua aprovação,
         se sua correção será avaliada somente pelo professor orientador, ou por todos
         membros da banca.
       </li>
     </ul>
    " 
  
,"g3834-0-6-5-9-8-7-3":"
      <strong>Etapa 28:</strong>
      <p>Após as correções solicitadas pela banca o aluno deve entregar a
         versão final do TCC  para o professor responsável juntamente com a
         ficha de encaminhamento da versão final do TCC, nas datas divulgadas
         em cada semestre.
      </p>"

,"g3834-0-6-5-9-8-8-4-6-8-5-2-0":"
     <strong>Etapa 29:</strong>
     <p>Nesta etapa o acadêmico deve:</p>
     <ul>
       <li>
         Versão final da proposta apresentada em TCC 1, com devidas correções;
       </li>
       <li>
         Versão final do projeto apresentado no final da disciplina de TCC 1, com devidas correções;
       </li>
       <li>
        Versão final da monografia com as correções sugeridas pela banca,
        juntamente com a cópia da ata de defesa anexada logo após a contra-capa;
       </li>
       <li>
         Código fonte, executável referentes ao trabalho se existirem;
       </li>
       <li>
         Documentos referentes ao depósito do trabalho na biblioteca;
       </li>
       <li>
         Verificar formato e padronização da entrega dos documentos, com o professor responsável.
       </li>
     </ul>"
}`;

var flow_str = popover_data.replace(/(\r\n|\n|\r)/gm,"")
var flowInfo = jQuery.parseJSON(flow_str);
